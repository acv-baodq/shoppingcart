require 'faker'

FactoryBot.define do
  factory :product do
    name { Faker::Book.title }
    description { Faker::Book.author }
    price { Faker::Number.decimal(2) }
  end
end
