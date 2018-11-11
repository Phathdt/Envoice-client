class AddStatusToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :state, :integer, default: 0, index: true
  end
end
