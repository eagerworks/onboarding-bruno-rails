require 'rails_helper'

RSpec.describe Gift, type: :model do
  include FactoryBot::Syntax::Methods
  it 'has a valid factory' do
    expect(build(:gift)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many :gift_categorizations }
    it { is_expected.to have_many(:categories).through(:gift_categorizations) }
    it { is_expected.to have_many :gift_customizations }
    it { is_expected.to have_many(:customizations).through(:gift_customizations) }
    it { is_expected.to have_many :purchases }
    it { is_expected.to belong_to :supplier }
    it { is_expected.to delegate_method(:name).to(:supplier).with_prefix }
    it { is_expected.to have_one_attached :image }
    it { is_expected.to have_rich_text :content }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_presence_of :valoration }
    it { is_expected.to validate_presence_of :supplier }
    it { is_expected.to validate_presence_of :image }
    it { is_expected.to validate_presence_of :categories }
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it {
      is_expected.to validate_numericality_of(:valoration).is_in(0..5)
    }
  end

  context 'instance methods' do
    let(:gift) { create(:gift) }

    describe '#image_resized' do
      it 'returns image resized' do
        expect(gift.image_resized).to be_an_instance_of ActiveStorage::VariantWithRecord
      end
    end
    describe '#image_resized_for_purchase' do
      it 'returns image resized for purchase' do
        expect(
          gift.image_resized_for_purchase
        ).to be_an_instance_of ActiveStorage::VariantWithRecord
      end
    end
  end

  describe '.with_categories' do
    it 'returns gifts from selected categories' do
      category1 = create(:category)
      category2 = create(:category)
      category3 = create(:category)
      gift1 = create(:gift, categories: [category1, category2])
      gift2 = create(:gift, categories: [category2])

      expect(described_class.with_categories([category1])).to contain_exactly(gift1)

      expect(described_class.with_categories([category2])).to contain_exactly(gift1, gift2)

      expect(described_class.with_categories([category3])).to contain_exactly
    end
  end
end
