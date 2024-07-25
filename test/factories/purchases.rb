FactoryBot.define do
  factory :purchase do
    RUT { Faker::Number.unique.number(digits: 8).to_s }
    social_reason { Faker::Company.name }
    suprise_delivery { Faker::Boolean.boolean }
    personalization { 'Hola, esta es el mensaje personalizado que te envío' }
    resend_delivery { Faker::Boolean.boolean }
    company_logo { nil }
    amount { Faker::Number.between(from: 1, to: 5) }
    after(:build) do |purchase|
      if purchase.destinations.empty?
        purchase.destinations = build_list(:destination, 1,
                                           purchase: purchase)
      end
      purchase.gift = create(:gift) if purchase.gift.nil?
      purchase.payment_method = create(:payment_method) if purchase.payment_method.nil?
      purchase.subtotal = purchase.amount * purchase.gift_price
      purchase.price = purchase.subtotal + (purchase.subtotal * 0.22).to_i + 180
    end
  end
end
