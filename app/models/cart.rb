class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  def get_total
    products.pluck(:price).sum
  end
end
