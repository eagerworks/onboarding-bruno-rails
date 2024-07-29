require 'rails_helper'

RSpec.describe Destination, type: :model do
  include FactoryBot::Syntax::Methods
  it 'has a valid factory' do
    expect(build(:destination)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to :purchase }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :receiver }
    it { is_expected.to validate_presence_of :day }
    it { is_expected.to validate_presence_of :schedules }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :number }
    it { is_expected.to validate_presence_of :cost }
    it { should validate_comparison_of(:day).is_greater_than(Date.today) }
  end
end
