class AddRoleToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer, default: 0
    add_index :users, :role
  end
end
