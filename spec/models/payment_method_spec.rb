require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it 'has a valid factory' do
    expect(build(:payment_method)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many :purchases }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :owner }
    it { is_expected.to validate_presence_of :card_number }
    it { is_expected.to validate_presence_of :due_date }
    it { is_expected.to validate_presence_of :CVV }
  end
end
