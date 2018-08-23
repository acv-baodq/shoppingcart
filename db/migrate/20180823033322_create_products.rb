class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precistion: 10, scale: 2
      t.timestamps
    end
  end
end
