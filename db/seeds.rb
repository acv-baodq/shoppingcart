require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

10.times do 
  category = Category.create(name: Faker::BreakingBad.character)
  100.times do
    Product.create(
      name: Faker::Pokemon.name,
      price: Faker::Number.decimal(2), 
      description: Faker::Lorem.question,
      category: category,
      img_url: Faker::Avatar.image
    )
  end
end
