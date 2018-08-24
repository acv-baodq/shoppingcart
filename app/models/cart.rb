class Cart < ApplicationRecord
  has_many :products

  def self.get_total
    first.products.reduce(0) { |sum, p| sum + p.price }
  end
end
