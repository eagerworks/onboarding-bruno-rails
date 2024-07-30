require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many :gift_categorizations }
    it { is_expected.to have_many(:gifts).through(:gift_categorizations) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end
end
