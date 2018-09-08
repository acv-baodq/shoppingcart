class Address < ApplicationRecord
  extend Enumerize
  belongs_to :user

  validates :line1, :city, :state, :country_code, presence: true

  enumerize :country_code, in: ISO3166::Country.translations.invert

  scope :locates, -> (user_id) { where(user_id: user_id).order("id DESC") }

  def located
    [line1, line2, city, state, country_code].reject(&:blank?).join(', ').titleize
  end
end
