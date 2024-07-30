require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many :payment_methods }
    it { is_expected.to accept_nested_attributes_for :payment_methods }
    it { is_expected.to have_many(:purchases).through(:payment_methods) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :company_name }
  end
end
