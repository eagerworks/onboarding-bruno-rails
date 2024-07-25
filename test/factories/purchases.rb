FactoryBot.define do
  factory :purchase do
    RUT { Faker::Number.unique.number(digits: 8) }
    social_reason { Faker::Company.name }
    payment_method { PaymentMethod.all.sample }
    gift { Gift.all.sample }
    suprise_delivery { Faker::Boolean.boolean }
    personalization { 'Hola, esta es el mensaje personalizado que te envío' }
    resend_delivery { Faker::Boolean.boolean }
    company_logo { nil }
    amount { Faker::Number.between(from: 1, to: 5) }
    subtotal { amount * gift.price }
    price { subtotal + (subtotal * 0.22).to_i + 180 }
    destinations { FactoryBot.create_list(:destination, 1) }
  end
end
