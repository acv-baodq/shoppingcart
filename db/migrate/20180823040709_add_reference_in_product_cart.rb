class AddReferenceInProductCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :category, index: true
    add_reference :products, :cart, index: true
  end
end
