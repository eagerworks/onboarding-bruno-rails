FactoryBot.define do
  factory :destination do
    receiver { Faker::Name.name }
    day { Faker::Date.forward(days: 30) }
    address { Faker::Address.street_address }
    number { Faker::PhoneNumber.cell_phone }
    schedules { "#{Faker::Number.between(from: 10, to: 18)}hs" }
    cost { Faker::Number.between(from: 1, to: 100) }
    purchase { nil }
  end
end
