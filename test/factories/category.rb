FactoryBot.define do
  factory :category do
    sequence :name do |n|
      ['Para Compartir', 'Sin azucar', 'Sin Tacc', 'Picadas', 'Veganos/Vegetarianos'][n % 5]
    end
  end
end
