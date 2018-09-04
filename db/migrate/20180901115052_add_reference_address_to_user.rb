class AddReferenceAddressToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :user, index: true
    add_column :addresses, :locate, :string
  end
end
