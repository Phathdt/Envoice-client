class AddIdServerToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :id_server, :bigint
  end
end
