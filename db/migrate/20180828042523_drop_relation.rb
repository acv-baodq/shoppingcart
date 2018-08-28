class DropRelation < ActiveRecord::Migration[5.2]
  def change
    drop_table :cart_products
    remove_column :carts, :total_price
    remove_column :carts, :uuid
    add_column :carts, :user_id, :integer, index: true
    add_column :carts, :data, :json, default: {}
  end
end
