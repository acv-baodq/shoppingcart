require 'faker'

FactoryBot.define do
  factory :user do
    first_name             {"first"}
    last_name              {"last"}
    email                  {"test@test.com"}
    phone                  {"2090292090"}
    password               {"baobaobao"}
    password_confirmation  {"baobaobao"}
  end
end
