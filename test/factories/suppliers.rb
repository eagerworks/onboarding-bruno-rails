FactoryBot.define do
  factory :supplier do
    name { Faker::Commerce.vendor }
  end
end
