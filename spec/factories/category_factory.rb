require 'faker'

FactoryBot.define do
  factory :category do
    name { Faker::Music.band }
  end
end
