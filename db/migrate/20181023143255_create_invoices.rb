class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :form_identifier
      t.string :serial_number
      t.string :invoice_number
      t.date :invoice_date
      t.integer :payment_method, default: 0
      t.decimal :vat_percent, default: 0
      t.string :customer_tax_identification_number
      t.string :transaction_id
      t.references :company, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
