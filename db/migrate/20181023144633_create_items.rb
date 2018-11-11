class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :product, foreign_key: true
      t.references :invoice, foreign_key: true
      t.integer :quantity, default: 0
      t.decimal :price, default: 0

      t.timestamps
    end
  end
end
