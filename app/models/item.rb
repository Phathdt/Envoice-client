class Item < ApplicationRecord
  belongs_to :product
  belongs_to :invoice

  before_create :update_price

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def total
    @total ||= quantity * price
  end

  def update_price
    self.price = product.price
  end
end
