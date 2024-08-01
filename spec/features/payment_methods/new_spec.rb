require 'rails_helper'

RSpec.describe 'new payment method', type: :feature do
  before(:each) do
    sign_in(create(:user, password: '123456'), scope: :user)
    visit new_payment_method_path
  end

  context 'with valid data' do
    it 'creates a new payment method' do
      fill_in 'payment_method_name', with: 'testingName'
      fill_in 'payment_method_owner', with: 'testingOwner'
      fill_in 'payment_method_card_number', with: '123456789'
      fill_in 'payment_method_due_date', with: Date.today
      fill_in 'payment_method_CVV', with: '123'
      click_button 'Agregar'

      click_link 'testingName'

      expect(page).to have_field('payment_method_name', with: 'testingName', disabled: true)
      expect(page).to have_field('payment_method_owner', with: 'testingOwner', disabled: true)
      expect(page).to have_field('payment_method_card_number', with: '123456789',
                                                               disabled: true)
      expect(page).to have_field('payment_method_due_date', with: Date.today, disabled: true)
      expect(page).to have_field('payment_method_CVV', with: '123', disabled: true)
    end
  end

  context 'with empty fields' do
    it 'does not create a new payment method' do
      fill_in 'payment_method_name', with: ''
      fill_in 'payment_method_owner', with: ''
      fill_in 'payment_method_card_number', with: ''
      fill_in 'payment_method_due_date', with: ''
      fill_in 'payment_method_CVV', with: ''
      click_button 'Agregar'

      expect(page).to have_current_path(payment_methods_path)
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.payment_method.attributes.name.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.payment_method.attributes.owner.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.payment_method.attributes.card_number.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.payment_method.attributes.due_date.blank'
        )
      )
      expect(page).to have_content(
        I18n.t(
          'activerecord.errors.models.payment_method.attributes.CVV.blank'
        )
      )
    end
  end
end
