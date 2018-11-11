class Customer < ApplicationRecord
  has_many :invoices

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, length: { minimum: 10, maximum: 11 }, presence: true
  validates :address, presence: true
  validates :name, presence: true
end
