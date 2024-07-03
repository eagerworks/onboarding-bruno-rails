FactoryBot.define do
  factory :gift do
    name { Faker::Food.dish }
    price { Faker::Number.between(from: 1, to: 1000) }
    valoration { Faker::Number.between(from: 0.0, to: 5.0).round(1) }
    supplier do
      Supplier.all.sample
    end
    categories do
      Category.all.sample(3)
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
    end
    # trait(:with_categories) do
    #   Category.all.sample(3)
    # end
  end
end
