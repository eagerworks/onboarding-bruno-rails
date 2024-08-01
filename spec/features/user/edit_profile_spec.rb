require 'rails_helper'

RSpec.describe 'Edit user', type: :feature do
  before(:each) do
    sign_in(create(:user, password: '123456'), scope: :user)
    visit edit_user_registration_path
  end

  context 'with valid data' do
    it 'updates user info' do
      fill_in 'user_name', with: 'New Name'
      fill_in 'user_last_name', with: 'New Last Name'
      fill_in 'user_company_name', with: 'New Company Name'
      fill_in 'user_email', with: 'new@gmail.com'
      fill_in 'user_current_password', with: '123456'

      click_button 'Actualizar'

      expect(page).to have_content(I18n.t('devise.registrations.updated'))

      visit users_show_path

      expect(page).to have_field('user_name', with: 'New Name', disabled: true)
      expect(page).to have_field('user_last_name', with: 'New Last Name', disabled: true)
      expect(page).to have_field('user_email', with: 'new@gmail.com', disabled: true)
      expect(page).to have_field('user_company_name', with: 'New Company Name', disabled: true)
    end
  end

  context 'with empty fields' do
    it 'does not update user info' do
      user = create(:user)
      sign_in(user, scope: :user)
      visit edit_user_registration_path
      fill_in 'user_name', with: ''
      fill_in 'user_last_name', with: ''
      fill_in 'user_company_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_current_password', with: '123456'

      click_button 'Actualizar'

      expect(page).to have_current_path(user_registration_path)
      expect(page).to have_content(I18n.t('errors.messages.blank'), count: 4)
    end
  end

  context 'with wrong current password' do
    it 'does not update user info' do
      fill_in 'user_current_password', with: 'wrongpassword'

      click_button 'Actualizar'

      expect(page).to have_current_path(user_registration_path)
      expect(page).to have_content(I18n.t('errors.attributes.current_password.invalid'))
    end
  end

  context 'with repeated email' do
    it 'does not update user info' do
      create(:user, email: 'test@gmail.com')
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_current_password', with: '123456'

      click_button 'Actualizar'

      expect(page).to have_current_path(user_registration_path)
      expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.email.taken'))
    end
  end

  context 'with short password' do
    it 'does not update user info' do
      fill_in 'user_password', with: 'spec'
      fill_in 'user_current_password', with: '123456'

      click_button 'Actualizar'

      expect(page).to have_current_path(user_registration_path)
      I18n.t('errors.messages.too_short.other')
    end
  end
end
