require 'rails_helper'

RSpec.describe Customization, type: :model do
  it 'has a valid factory' do
    expect(build(:customization)).to be_valid
  end

  describe 'associatons' do
    it { is_expected.to have_many :gift_customizations }
    it { is_expected.to have_many(:gifts).through(:gift_customizations) }
    it { is_expected.to have_and_belong_to_many :purchases }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  end
end
