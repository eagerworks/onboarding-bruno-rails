FactoryBot.define do
  factory :payment_method do
    name { 'MyString' }
    owner { 'MyString' }
    card_number { 'MyString' }
    due_date { '2024-07-09' }
    CVV { 'MyString' }
    user { nil }
  end
end
