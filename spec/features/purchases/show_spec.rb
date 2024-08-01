require 'rails_helper'

RSpec.describe 'purchase show', type: :feature do
  context 'when user visits purchase show page' do
    it 'shows purchase info' do
      purchase = create(:purchase, resend_delivery: true, suprise_delivery: true)
      sign_in(purchase.payment_method.user, scope: :user)
      visit purchase_path(purchase)
      expect(page).to have_content(purchase.gift_name)
      expect(page).to have_content(purchase.gift.supplier_name)
      expect(page).to have_content(purchase.price)
      expect(page).to have_content(purchase.amount)
      expect(page).to have_content(purchase.price)
      expect(page).to have_content(purchase.RUT)
      expect(page).to have_content(purchase.social_reason)
      expect(page).to have_content(purchase.personalization)
      expect(page).to have_content(purchase.payment_method_name)
      expect(page).to have_css("img[src*='tic']", count: 2)
      expect(page).to have_css("img[src*='cross']")
      purchase.destinations.each do |destination|
        expect(page).to have_content(destination.receiver)
        expect(page).to have_content(destination.address)
        expect(page).to have_content(destination.day)
        expect(page).to have_content(destination.number)
        expect(page).to have_content(destination.schedules)
        expect(page).to have_content(destination.cost)
      end
    end
  end

  context 'when user visits purchase without resend delivery, suprise_delivery and company_logo' do
    it 'shows the correct images' do
      purchase = create(:purchase, resend_delivery: false, suprise_delivery: false)
      sign_in(purchase.payment_method.user, scope: :user)
      visit purchase_path(purchase)
      expect(page).to have_css("img[src*='cross']", count: 3)
    end
  end

  context 'when user visits purchase with company_logo' do
    it 'shows the correct image' do
      purchase = create(:purchase, :with_company_logo)
      sign_in(purchase.payment_method.user, scope: :user)
      visit purchase_path(purchase)
      expect(page).to have_css("img[src*='#{purchase.company_logo.blob.filename}']")
    end
  end

  context 'when user visits purchase with one destination', js: true do
    it 'show the only destination' do
      purchase = create(:purchase)
      sign_in(purchase.payment_method.user, scope: :user)
      visit purchase_path(purchase)
      expect(page).to have_button('<', disabled: true)
      expect(page).to have_button('>', disabled: true)
    end
  end

  context 'when user visits purchase with more than one destination', js: true do
    it 'shows the all destination' do
      purchase = create(:purchase, :with_mutliple_destinations)
      sign_in(purchase.payment_method.user, scope: :user)
      visit purchase_path(purchase)

      expect(page).to have_button('<', disabled: true)
      expect(page).to have_button('>')
      purchase.destinations.each do |destination|
        expect(page).to have_content(destination.receiver)
        expect(page).to have_content(destination.address)
        expect(page).to have_content(destination.day)
        expect(page).to have_content(destination.number)
        expect(page).to have_content(destination.schedules)
        expect(page).to have_content(destination.cost)
        click_button('>') unless purchase.destinations.last == destination
      end
      expect(page).to have_button('>', disabled: true)
      expect(page).to have_button('<')
    end
  end

  context 'when user visits purchase with no customization' do
    it 'does not show customization' do
      purchase = create(:purchase)
      sign_in(purchase.payment_method.user, scope: :user)
      visit purchase_path(purchase)
      expect(page).to have_content('Personalizaciones Incluidas: Ninguna')
    end
  end

  context 'when user visits purchase with customizations' do
    it 'shows customizations' do
      gift = create(:gift, :with_customizations)
      purchase = create(:purchase, gift: gift, customizations: gift.customizations)
      sign_in(purchase.payment_method.user, scope: :user)
      visit purchase_path(purchase)
      gift.customizations.each do |customization|
        expect(page).to have_content(customization.name)
      end
    end
  end
end
