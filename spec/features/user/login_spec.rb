require 'rails_helper'

RSpec.feature 'user login', type: :feature do
  let!(:user) { create(:user, password: 'specspec') }

  context 'with valid credentials' do
    it 'redirects logged in user to root path' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Iniciar Sesión'

      expect(page).to have_current_path(root_path)
    end
  end

  context 'with invalid credentials' do
    it 'does not log in user' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'wrongpassword'
      click_button 'Iniciar Sesión'

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
