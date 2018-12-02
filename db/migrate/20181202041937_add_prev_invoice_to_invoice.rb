class AddPrevInvoiceToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :prev_invoice, :integer
    add_index :invoices, :prev_invoice
  end
end
