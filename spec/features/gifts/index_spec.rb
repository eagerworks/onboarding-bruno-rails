require 'rails_helper'

RSpec.describe 'Gift index', type: :feature do
  let!(:categories) { create_list(:category, 5, :with_gifts) }
  before(:each) do
    sign_in(create(:user), scope: :user)
    visit root_path
  end

  context 'At root page' do
    it 'shows all gifts' do
      categories.each do |category|
        category.gifts.each do |gift|
          expect(page).to have_css("li[data-value='#{gift.id}']")
        end
      end
    end
  end

  context 'with category filters applied', js: true do
    it 'shows filtered gifts' do
      find("label[for='classes_filter_categories_ids_#{categories[0].id}']").click
      categories[0].gifts.each do |gift|
        expect(page).to have_css("li[data-value='#{gift.id}']")
      end
      categories[1..].each do |category|
        category.gifts.each do |gift|
          expect(page).not_to have_css("li[data-value='#{gift.id}']")
        end
      end
      find("label[for='classes_filter_categories_ids_#{categories[1].id}']").click
      categories[0..1].each do |category|
        category.gifts.each do |gift|
          expect(page).to have_css("li[data-value='#{gift.id}']")
        end
      end
      categories[2..].each do |category|
        category.gifts.each do |gift|
          expect(page).not_to have_css("li[data-value='#{gift.id}']")
        end
      end
    end
  end

  context 'with order filters applied', js: true do
    it 'shows ordered gifts' do
      select 'Precio', from: 'classes_filter_order'
      all('li').each_cons(2) do |li1, li2|
        price1 = li1.text.split('$').last.to_i
        price2 = li2.text.split('$').last.to_i
        expect(price1).to be <= price2
      end

      select 'Nombre', from: 'classes_filter_order'
      all('li').each_cons(2) do |li1, li2|
        name1 = li1.text.split('\n').first.first
        name2 = li2.text.split('\n').first.first
        expect(name1).to be <= name2
      end
    end
  end
end
