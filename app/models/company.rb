class Company < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :accounts, dependent: :destroy

  validates :name, presence: true
  validates :phone_number, length: { minimum: 10, maximum: 11 }, presence: true
  validates :tax_identification_number, presence: true
  validates :address, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
