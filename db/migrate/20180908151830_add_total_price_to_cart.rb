class AddTotalPriceToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :total_price, :decimal, precision: 10, scale: 2, default: 0
  end
end
