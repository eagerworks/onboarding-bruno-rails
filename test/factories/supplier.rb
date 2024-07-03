FactoryBot.define do
  factory :supplier do
    name { Faker::Commerce.unique.vendor }
  end
end
