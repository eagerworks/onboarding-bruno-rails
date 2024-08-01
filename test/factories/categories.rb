FactoryBot.define do
  factory :category do
    sequence :name do |n|
      ['Para Compartir', 'Sin azucar', 'Sin Tacc', 'Picadas', 'Veganos/Vegetarianos'][n % 5]
    end
  end

  trait :with_gifts do
    after(:create) do |category|
      create_list(:gift, 3, categories: [category])
    end
  end
end
