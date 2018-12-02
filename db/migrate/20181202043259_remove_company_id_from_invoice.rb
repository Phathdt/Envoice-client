class RemoveCompanyIdFromInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :company_id, :string
  end
end
