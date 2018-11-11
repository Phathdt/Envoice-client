class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :private_key
      t.string :public_key
      t.string :address
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
