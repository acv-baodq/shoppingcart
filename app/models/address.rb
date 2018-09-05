class Address < ApplicationRecord
  extend Enumerize
  belongs_to :user

  validates :line1, :city, :country_code, presence: true

  enumerize :country_code, in: ISO3166::Country.translations.invert
end
