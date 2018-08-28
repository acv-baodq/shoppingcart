class AddUuidToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :uuid, :string
  end
end
