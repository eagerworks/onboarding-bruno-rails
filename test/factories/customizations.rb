FactoryBot.define do
  factory :customization do
    name { Faker::Food.unique.ingredient }
    price { Faker::Number.between(from: 1, to: 100) }
  end
end
