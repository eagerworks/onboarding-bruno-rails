FactoryBot.define do
  factory :gift do
    name { Faker::Food.unique.dish }
    price { Faker::Number.between(from: 1, to: 1000) }
    valoration { Faker::Number.between(from: 0.0, to: 5.0).round(1) }

    content do
      GIFT_CONTENT_LISTS.sample
    end

    after(:build) do |gift|
      image_folder = Rails.root.join('test', 'assets', 'images')
      images = Dir.entries(image_folder).reject { |f| File.directory?(File.join(image_folder, f)) }
      random_image = images.sample
      gift.image.attach(
        io: File.open(File.join(image_folder, random_image)),
        filename: random_image,
        content_type: 'image/png'
      )
      gift.supplier ||= create(:supplier)
      gift.categories = create_list(:category, 3) if gift.categories.empty?
    end

    trait(:with_customizations) do
      after(:create) do |gift|
        gift.customizations = create_list(:customization, 3, gifts: [gift])
      end
    end
  end
end
