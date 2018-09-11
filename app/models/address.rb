class Address < ApplicationRecord
  extend Enumerize
  belongs_to :user

  validates :line1, :city, :state, :country_code, presence: true
  validates :postal_code, numericality: true

  enumerize :country_code, in: ISO3166::Country.translations.invert

  scope :locates, -> (user_id) { where(user_id: user_id).order("id DESC") }
  scope :get_selected, -> (user_id) { where(user_id: user_id ,selected: true).first }

  def located
    [line1, line2, city, state, country_code].reject(&:blank?).join(', ').titleize
  end

  def self.change_selected_address(user_id)
    where(user_id: user_id).update_all(selected: false)
  end
end
