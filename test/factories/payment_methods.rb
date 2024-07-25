FactoryBot.define do
  factory :payment_method do
    name { Faker::Bank.name }
    owner { Faker::Name.name }
    card_number { Faker::Bank.account_number }
    due_date { Faker::Date.between(from: Date.today, to: 4.year.from_now) }
    CVV { Faker::Number.number(digits: 3) }
    after(:build) do |payment_method|
      payment_method.user ||= build(:user, payment_methods: [payment_method])
    end
  end
end
