class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :items, dependent: :destroy

  enum state: { pending: 0, suspended: 1, approved: 2 }

  has_one_attached :image
  has_one_attached :pdf

  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  validates :form_identifier, presence: true
  validates :serial_number, presence: true
  validates :invoice_number, presence: true
  validates :invoice_date, presence: true
  validates :payment_method, presence: true
  validates :vat_percent, presence: true

  # after_update :up_block, if: :approved?
  # after_update :render_report

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
    self.update(hash_data: value)
  end

  def up_block
    return unless approved? && !up_data?
    update_hash_data
    TransactionGenerator.perform_later(self, self.company.account)
    InvoiceMailer.send_customer(self, self.customer).deliver_now
    # self.update(up_data: true)
  end

  def render_report
    RenderReportJob.perform_now(self)
  end
end
