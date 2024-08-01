require 'rails_helper'

RSpec.describe 'gift show', type: :feature do
  let(:gift) { create(:gift) }
  let(:gift_with_customizations) { create(:gift, :with_customizations) }
  before(:each) do
    sign_in(create(:user), scope: :user)
  end

  context 'when user visits gift show page' do
    it 'shows gift info' do
      visit gift_path(gift)
      expect(page).to have_content(gift.name)
      expect(page).to have_content(gift.valoration)
      expect(page).to have_content(gift.supplier_name)
      expect(page).to have_field('price', with: gift.price)
      expect(page.body).to include(gift.content.to_s)
      expect(page).to have_css("img[src*='#{Rails.application.routes.url_helpers.rails_blob_path(
        gift.image, only_path: true
      )}']")
    end
  end

  context 'when user visits gift show page with customizations' do
    it 'shows gift info and customizations' do
      visit gift_path(gift_with_customizations)
      expect(page).to have_content(gift_with_customizations.name)
      expect(page).to have_content(gift_with_customizations.valoration)
      expect(page).to have_content(gift_with_customizations.supplier_name)
      expect(page).to have_field('price', with: gift_with_customizations.price)

      gift.customizations.each do |customization|
        expect(page).to have_content(customization.name)
        expect(page).to have_content(customization.price)
      end
    end
  end

  context 'when user adds customization to the purchase', js: true do
    it 'updates the price' do
      visit gift_path(gift_with_customizations)
      gift_with_customizations.customizations.each do |customization|
        check("customization_ids_#{customization.id}")
      end
      expect(find_field('price',
                        readonly: true).value.to_i).to eq(gift_with_customizations.price +
                        gift_with_customizations.customizations.sum(&:price))
    end
  end
end
