class AddUserToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :user, index: true
  end
end
