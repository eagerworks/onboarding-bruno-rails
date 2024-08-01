require 'rails_helper'

RSpec.describe 'Sign up', type: :feature do
  before(:each) do
    visit new_user_registration_path
  end

  context 'with valid inputs' do
    it 'creates a new user' do
      fill_in 'user_name', with: 'testingName'
      fill_in 'user_last_name', with: 'testingLastName'
      fill_in 'user_email', with: 'testing@gmail.com'
      fill_in 'user_password', with: 'specspec'
      fill_in 'user_company_name', with: 'testingCompany'
      click_button 'Registrarse'

      expect(page).to have_current_path(root_path)

      visit users_show_path

      expect(page).to have_field('user_name', with: 'testingName', disabled: true)
      expect(page).to have_field('user_last_name', with: 'testingLastName', disabled: true)
      expect(page).to have_field('user_email', with: 'testing@gmail.com', disabled: true)
      expect(page).to have_field('user_company_name', with: 'testingCompany', disabled: true)
    end
  end

  context 'with blank input' do
    it 'does not create a new user' do
      fill_in 'user_name', with: ''
      fill_in 'user_last_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_company_name', with: ''
      click_button 'Registrarse'

      expect(page).to have_current_path(user_registration_path)
      expect(page).to have_content(I18n.t('errors.messages.blank'), count: 4)
      expect(page).to have_content(
        I18n.t('activerecord.errors.models.user.attributes.password.blank')
      )
    end
  end

  context 'with repeated email' do
    it 'does not create a new user' do
      create(:user, email: 'testing@gmail.com')
      fill_in 'user_name', with: 'testingName'
      fill_in 'user_last_name', with: 'testingLastName'
      fill_in 'user_email', with: 'testing@gmail.com'
      fill_in 'user_password', with: 'specspec'
      fill_in 'user_company_name', with: 'testingCompany'
      click_button 'Registrarse'

      expect(page).to have_current_path(user_registration_path)
      expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.email.taken'))
    end
  end

  context 'with short password' do
    it 'does not create a new user' do
      fill_in 'user_name', with: 'testingName'
      fill_in 'user_last_name', with: 'testingLastName'
      fill_in 'user_email', with: 'testing@gmail.com'
      fill_in 'user_password', with: 'spec'
      fill_in 'user_company_name', with: 'testingCompany'
      click_button 'Registrarse'

      expect(page).to have_current_path(user_registration_path)
      I18n.t('errors.messages.too_short.other')
    end
  end
end
