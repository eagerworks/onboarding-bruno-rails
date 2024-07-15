FactoryBot.define do
  factory :destination do
    receiver { 'MyString' }
    day { '2024-07-10' }
    address { 'MyString' }
    number { 'MyString' }
    schedules { 'MyString' }
    cost { 'MyString' }
    purchase { nil }
  end
end
