class Product < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :unit, presence: true
  validates :price, presence: true, numericality: true
end
