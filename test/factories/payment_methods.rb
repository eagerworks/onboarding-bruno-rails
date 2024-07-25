FactoryBot.define do
  factory :payment_method do
    name { Faker::Bank.name }
    owner { Faker::Name.name }
    card_number { Faker::Bank.account_number }
    due_date { Faker::Date.between(from: Date.today, to: 4.year.from_now) }
    CVV { Faker::Number.number(digits: 3) }
    user { nil }
  end
end
