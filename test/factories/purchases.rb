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
      purchase.gift ||= create(:gift)
      purchase.payment_method ||= create(:payment_method)
      purchase.subtotal = purchase.amount * purchase.gift_price
      purchase.price = purchase.subtotal + (purchase.subtotal * 0.22).to_i + 180
    end

    trait(:with_mutliple_destinations) do
      after(:build) do |purchase|
        purchase.destinations = build_list(:destination, 3,
                                           purchase: purchase)
      end
    end

    trait(:with_company_logo) do
      after(:build) do |purchase|
        image_folder = Rails.root.join('test', 'assets', 'images')
        images = Dir.entries(image_folder).reject do |f|
          File.directory?(File.join(image_folder, f))
        end
        random_image = images.sample
        purchase.company_logo.attach(
          io: File.open(File.join(image_folder, random_image)),
          filename: random_image,
          content_type: 'image/png'
        )
      end
    end
  end
end
