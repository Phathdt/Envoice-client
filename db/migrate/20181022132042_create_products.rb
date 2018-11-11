class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :unit
      t.decimal :price, default: 0

      t.timestamps
    end
  end
end
