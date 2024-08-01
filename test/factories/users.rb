FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company_name { Faker::Company.name }
  end

  trait(:with_payment_methods) do
    after(:create) do |user|
      user.payment_methods = create_list(:payment_method, 3, user: user)
    end
  end
end
