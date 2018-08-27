class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  def self.get_total
    first.products.pluck(:price).sum
  end
end
