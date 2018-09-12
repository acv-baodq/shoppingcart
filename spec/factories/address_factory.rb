require 'faker'

FactoryBot.define do
  factory :address do
    line1 { Faker::Address.street_name }
    line2 { 'Line2' }
    city { 'city' }
    state { 'state' }
    postal_code { '40420' }
    country_code { 'Viet Nam' }
    user
  end
end
