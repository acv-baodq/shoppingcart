class Product < ApplicationRecord
  belongs_to :category, optional: true

  validates_presence_of :name
  validates_presence_of :description
  validates :price, presence: true, numericality: true
end
