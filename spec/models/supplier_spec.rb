require 'rails_helper'

RSpec.describe Supplier, type: :model do
  it 'has a valid factory' do
    expect(build(:supplier)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many :gifts }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end
end
