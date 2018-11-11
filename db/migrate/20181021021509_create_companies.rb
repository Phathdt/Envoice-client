class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :legal_representative
      t.string :phone_number
      t.string :tax_identification_number
      t.string :address
      t.string :email

      t.timestamps
    end
  end
end
