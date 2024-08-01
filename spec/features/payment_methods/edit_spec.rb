require 'rails_helper'

RSpec.describe 'Edit payment method', type: :feature do
  let(:payment_method) { create(:payment_method) }
  before(:each) do
    sign_in(payment_method.user, scope: :user)
    visit edit_payment_method_path(payment_method)
  end

  context 'with valid data' do
    it 'updates the payment method' do
      fill_in 'payment_method_name', with: 'testingName'
      fill_in 'payment_method_owner', with: 'testingOwner'
      fill_in 'payment_method_card_number', with: '123456789'
      fill_in 'payment_method_due_date', with: Date.today
      fill_in 'payment_method_CVV', with: '123'
      click_button 'Actualizar'

      expect(page).to have_current_path(payment_methods_path)
      expect(page).to have_content('testingName - testingOwner')
    end
  end

  context 'with empty fields' do
    it 'does not update the payment method' do
      fill_in 'payment_method_name', with: ''
      fill_in 'payment_method_owner', with: ''
      fill_in 'payment_method_card_number', with: ''
      fill_in 'payment_method_due_date', with: ''
      fill_in 'payment_method_CVV', with: ''
      click_button 'Actualizar'

      expect(page).to have_current_path(payment_method_path(payment_method))
      expect(page).to have_content(
        I18n.t('activerecord.errors.models.payment_method.attributes.name.blank')
      )
      expect(page).to have_content(
        I18n.t('activerecord.errors.models.payment_method.attributes.owner.blank')
      )
      expect(page).to have_content(
        I18n.t('activerecord.errors.models.payment_method.attributes.card_number.blank')
      )
      expect(page).to have_content(
        I18n.t('activerecord.errors.models.payment_method.attributes.due_date.blank')
      )
      expect(page).to have_content(
        I18n.t('activerecord.errors.models.payment_method.attributes.CVV.blank')
      )
    end
  end
end
