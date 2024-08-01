require 'rails_helper'

RSpec.describe 'purchase index', type: :feature do
  let!(:user) { create(:user, :with_payment_methods) }
  let!(:purchases) { create_list(:purchase, 5, payment_method: user.payment_methods.first) }

  context 'with a user with purchases' do
    it 'shows them' do
      sign_in(user, scope: :user)
      visit purchases_path

      purchases.each do |purchase|
        expect(page).to have_content(purchase.gift.name.truncate(10, separator: ' '))
        expect(page).to have_content(purchase.gift.price)
        expect(page).to have_content(I18n.l(purchase.created_at, format: '%d/%Y'))
      end
    end
  end
end
