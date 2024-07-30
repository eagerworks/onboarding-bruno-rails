require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it 'has a valid factory' do
    expect(build(:purchase)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to :payment_method }
    it { is_expected.to have_one(:user).through(:payment_method) }
    it { is_expected.to belong_to :gift }
    it { is_expected.to have_many :destinations }
    it { is_expected.to accept_nested_attributes_for :destinations }
    it { is_expected.to have_and_belong_to_many :customizations }
    it { is_expected.to accept_nested_attributes_for :customizations }
    it { is_expected.to have_one_attached :company_logo }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    it { is_expected.to validate_presence_of :personalization }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :social_reason }
    it { is_expected.to validate_presence_of :RUT }
    it { is_expected.to validate_presence_of :destinations }
    it { is_expected.to validate_presence_of :payment_method }
    it { is_expected.to delegate_method(:price).to(:gift).with_prefix }
    it { is_expected.to delegate_method(:name).to(:gift).with_prefix }
    it { is_expected.to delegate_method(:name).to(:payment_method).with_prefix }
    it { is_expected.to delegate_method(:email).to(:user).with_prefix }
  end

  context 'instance methods' do
    let(:customization1) { create(:customization) }
    let(:customization2) { create(:customization) }
    let(:gift) { create(:gift, customizations: [customization1, customization2]) }
    let(:purchase) do
      create(:purchase, gift: gift,
                        customizations: [customization1, customization2])
    end

    describe '#subtotal' do
      it 'returns the gift price plus the prices of
          the customizatios selected multiplied by amount' do
        expect(purchase.subtotal).to eq(
          (gift.price + customization1.price + customization2.price) * purchase.amount
        )
      end
    end

    describe '#price' do
      it 'returns the subtotal plus IVA plus delivery' do
        expect(purchase.price).to eq(
          purchase.subtotal + (purchase.subtotal * 0.22).to_i + 180
        )
      end
    end
  end
end
