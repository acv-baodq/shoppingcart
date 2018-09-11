require 'faker'

FactoryBot.define do
  factory :cart do
    data  {{
      "1"=> {
        "id"=>1,
        "name"=>"Ninetales",
        "description"=>"Optio reprehenderit accusamus quibusdam?",
        "price"=>"45.10",
        "img_url"=>"https://robohash.org/etaliquidquasi.png?size=300x300&set=set1",
        "quantity"=>"1"
      },
      "2"=> {
        "id"=>2,
        "name"=>"Nidoran",
        "description"=>"Alias sunt vitae nihil?",
        "price"=>"52.90",
        "img_url"=>"https://robohash.org/aauteaque.png?size=300x300&set=set1",
        "quantity"=>"1"
      }
    }}
    total_price {98.00}
  end
end
