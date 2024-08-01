require 'rails_helper'

RSpec.describe 'Index payment method', type: :feature do
  context 'with a user with payment methods' do
    it 'shows them' do
      user = create(:user)
      sign_in(user, scope: :user)
      payment_methods = create_list(:payment_method, 5, user: user)
      visit payment_methods_path
      payment_methods.each do |payment_method|
        expect(page).to have_content("#{payment_method.name} - #{payment_method.owner}")
      end
    end
  end
end
