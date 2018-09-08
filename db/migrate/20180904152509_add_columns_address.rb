class AddColumnsAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :line1, :string
    add_column :addresses, :line2, :string
    add_column :addresses, :city, :string
    add_column :addresses, :state, :string
    add_column :addresses, :country_code, :string, limit: 2
    add_column :addresses, :postal_code, :string
    remove_column :addresses, :locate
  end
end
