class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :items, dependent: :destroy

  enum state: { pending: 0, suspended: 1, approved: 2 }

  has_one_attached :pdf

  validates :payment_method, presence: true
  validates :vat_percent, presence: true

  before_create :add_default
  before_update :add_invoice_number, if: Proc.new { |invoice| invoice.approved? && !invoice.invoice_number }
  before_update :update_hash_data, if: Proc.new { |invoice| invoice.approved? && invoice.update_hash_data.blank? }
  after_update :up_block, if: :approved?
  after_update :up_block_cancle, if: :suspended?

  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  def total
    @total ||= items.map(&:total).inject(:+) || 0
  end

  def vat_amount
    @vat_amount ||= total * vat_percent / 100
  end

  def paid_amount
    @paid_amount ||= total + vat_amount
  end

  def update_hash_data
    value = InvoiceSerializer.new(self).to_json
    self.hash_data = value
  end

  def up_block
    UpBlockJob.set(wait: 5.seconds).perform_later(self)
  end

  def up_block_cancle
    UpBlockCancleJob.set(wait: 5.seconds).perfrom_later(self)
  end

  def render_report
    RenderReportJob.perform_later(self)
  end

  def add_default
    self.form_identifier = '01GTKT'
    self.invoice_date = Date.current
    self.serial_number = Date.current.strftime("%yE")
  end

  def add_invoice_number
    self.invoice_number = (Invoice.where.not(invoice_number: nil).order(invoice_number: :DESC).first&.invoice_number.to_i + 1 ).to_s.rjust(6, "0")
  end

  def cancle_prev_invoice
    return unless self.prev_invoice

    old_invoice = Invoice.find(self.prev_invoice)

    old_invoice.suspended!
  end

  def delete_all_draft
    return unless self.prev_invoice

    draft_invoices = Invoice.where(prev_invoice: prev_invoice).where.not(id: self.id)

    draft_invoices.each(&:destroy)
  end
end
