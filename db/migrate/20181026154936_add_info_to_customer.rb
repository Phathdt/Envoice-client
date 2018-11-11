class AddInfoToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :company_name, :string
    add_column :customers, :tax_number, :string
  end
end
