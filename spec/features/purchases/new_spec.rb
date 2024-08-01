require 'rails_helper'

RSpec.describe 'new purchase', type: :feature do
  let!(:user) { create(:user, :with_payment_methods) }
  let!(:gift) { create(:gift) }
  before(:each) do
    sign_in(user, scope: :user)
    visit gift_path(gift)
  end

  context 'with valid data' do
    it 'creates a new purchase' do
      first(:button, 'Comprar ahora', visible: true).click
      expect(page).to have_field('purchase_subtotal', with: gift.price, readonly: true)
      expect(page).to have_content(gift.name)

      fill_in 'purchase_RUT', with: '123456789'
      fill_in 'purchase_social_reason', with: 'testingSocialReason'
      fill_in 'purchase_personalization', with: 'testingPersonalization'

      fill_in 'purchase_destinations_attributes_0_receiver', with: 'testingReceiver'
      fill_in 'purchase_destinations_attributes_0_address', with: 'testingAddress'
      fill_in 'purchase_destinations_attributes_0_day', with: Date.today + 1
      fill_in 'purchase_destinations_attributes_0_number', with: '1212'
      fill_in 'purchase_destinations_attributes_0_schedules', with: 'testingSchedules'
      fill_in 'purchase_destinations_attributes_0_cost', with: 'none'

      first(:button, 'Comprar', visible: true).click
      expect(page).to have_current_path(confirmation_purchases_path)

      visit purchases_path

      find('a[href^="/compras/"]').click

      expect(page).to have_content(gift.name)
      expect(page).to have_content((gift.price + (gift.price * 0.22) + 180).to_i)
      expect(page).to have_content('testingSocialReason')
      expect(page).to have_content('testingPersonalization')
      expect(page).to have_content('testingReceiver')
      expect(page).to have_content('testingAddress')
      expect(page).to have_content(Date.today + 1)
      expect(page).to have_content('1212')
      expect(page).to have_content('123456789')
      expect(page).to have_content('testingSchedules')
      expect(page).to have_content('none')
    end
  end

  context 'with empty fields' do
    it 'does not create a new purchase' do
      first(:button, 'Comprar ahora', visible: true).click
      first(:button, 'Comprar', visible: true).click

      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.purchase.attributes.RUT.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.purchase.attributes.social_reason.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.purchase.attributes.personalization.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.destination.attributes.receiver.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.destination.attributes.address.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.destination.attributes.day.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.destination.attributes.number.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.destination.attributes.schedules.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.destination.attributes.cost.blank'
        )
      )
    end
  end

  context 'with more than one destination', js: true do
    it 'creates a new purchase' do
      first(:button, 'Comprar ahora', visible: true).click

      fill_in 'purchase_RUT', with: '123456789'
      fill_in 'purchase_social_reason', with: 'testingSocialReason'
      fill_in 'purchase_personalization', with: 'testingPersonalization'

      fill_in 'purchase_destinations_attributes_0_receiver', with: 'testingReceiver'
      fill_in 'purchase_destinations_attributes_0_address', with: 'testingAddress'
      fill_in 'purchase_destinations_attributes_0_day', with: Date.today + 1
      fill_in 'purchase_destinations_attributes_0_number', with: '1212'
      fill_in 'purchase_destinations_attributes_0_schedules', with: 'testingSchedules'
      fill_in 'purchase_destinations_attributes_0_cost', with: 'none'

      find('button#add').click
      fill_in 'purchase_destinations_attributes_1_receiver', with: 'testingReceiver2'
      fill_in 'purchase_destinations_attributes_1_address', with: 'testingAddress2'
      fill_in 'purchase_destinations_attributes_1_day', with: Date.today + 2
      fill_in 'purchase_destinations_attributes_1_number', with: '3434'
      fill_in 'purchase_destinations_attributes_1_schedules', with: 'testingSchedules2'
      fill_in 'purchase_destinations_attributes_1_cost', with: 'none2'

      first(:button, 'Comprar', visible: true).click
      expect(page).to have_current_path(confirmation_purchases_path)

      visit purchases_path

      find('a[href^="/compras/"]').click
      click_button '>'

      expect(page).to have_content('testingReceiver2')
      expect(page).to have_content('testingAddress2')
      expect(page).to have_content(Date.today + 2)
      expect(page).to have_content('3434')
      expect(page).to have_content('testingSchedules2')
      expect(page).to have_content('none2')
    end
  end

  context 'with suprise_delivery and resend_delivery' do
    it 'creates a new purchase' do
      first(:button, 'Comprar ahora', visible: true).click

      fill_in 'purchase_RUT', with: '123456789'
      fill_in 'purchase_social_reason', with: 'testingSocialReason'
      fill_in 'purchase_personalization', with: 'testingPersonalization'

      fill_in 'purchase_destinations_attributes_0_receiver', with: 'testingReceiver'
      fill_in 'purchase_destinations_attributes_0_address', with: 'testingAddress'
      fill_in 'purchase_destinations_attributes_0_day', with: Date.today + 1
      fill_in 'purchase_destinations_attributes_0_number', with: '1212'
      fill_in 'purchase_destinations_attributes_0_schedules', with: 'testingSchedules'
      fill_in 'purchase_destinations_attributes_0_cost', with: 'none'

      check 'purchase_suprise_delivery'
      check 'purchase_resend_delivery'

      first(:button, 'Comprar', visible: true).click
      expect(page).to have_current_path(confirmation_purchases_path)

      visit purchases_path

      find('a[href^="/compras/"]').click

      expect(page).to have_css("img[src*='tic']", count: 2)
    end
  end

  context 'with company_logo' do
    it 'creates a new purchase' do
      first(:button, 'Comprar ahora', visible: true).click

      fill_in 'purchase_RUT', with: '123456789'
      fill_in 'purchase_social_reason', with: 'testingSocialReason'
      fill_in 'purchase_personalization', with: 'testingPersonalization'

      fill_in 'purchase_destinations_attributes_0_receiver', with: 'testingReceiver'
      fill_in 'purchase_destinations_attributes_0_address', with: 'testingAddress'
      fill_in 'purchase_destinations_attributes_0_day', with: Date.today + 1
      fill_in 'purchase_destinations_attributes_0_number', with: '1212'
      fill_in 'purchase_destinations_attributes_0_schedules', with: 'testingSchedules'
      fill_in 'purchase_destinations_attributes_0_cost', with: 'none'

      attach_file('purchase_company_logo', "#{Rails.root}/test/assets/images/Dulce.png")

      first(:button, 'Comprar', visible: true).click
      expect(page).to have_current_path(confirmation_purchases_path)

      visit purchases_path

      find('a[href^="/compras/"]').click

      expect(page).to have_css("img[src*='Dulce.png']")
    end
  end
end
