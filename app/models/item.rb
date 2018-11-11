class Item < ApplicationRecord
  belongs_to :product
  belongs_to :invoice

  before_create :update_price

  def total
    @total ||= quantity * price
  end

  def update_price
    self.price = product.price
  end
end
