class Product < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :unit, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
