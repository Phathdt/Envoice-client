class AddHashDataToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :hash_data, :string
  end
end
