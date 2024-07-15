FactoryBot.define do
  factory :purchase do
    RUT { 'MyString' }
    social_reason { 'MyString' }
    price { 1 }
    payment_method { nil }
    gift { nil }
    suprise_delivery { false }
    personalization { 'MyString' }
    resend_delivery { false }
    company_logo { nil }
  end
end
