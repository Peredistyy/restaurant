FactoryBot.define do
  factory :recipe do
    name { Faker::Lorem.word }
    instructions { Faker::Lorem.sentence }
    image_url { Faker::Internet.url }
    third_party_id { Faker::Number.number(digits: 3) }
    third_party_provider_name { 'themealdb' }
  end
end