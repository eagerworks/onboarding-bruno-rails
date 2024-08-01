class Gift < ApplicationRecord
  has_many :gift_categorizations, dependent: :destroy
  has_many :categories, through: :gift_categorizations
  has_many :gift_customizations, dependent: :destroy
  has_many :customizations, through: :gift_customizations
  has_many :purchases, dependent: :destroy
  belongs_to :supplier
  delegate :name, to: :supplier, prefix: true
  has_one_attached :image
  has_rich_text :content

  validates :name, :price, :valoration, :supplier, :image, :categories,
            :content, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :valoration, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  scope :with_categories, lambda { |categories|
    joins(:gift_categorizations)
      .where(gift_categorizations: { category_id: categories })
      .distinct
  }

  def image_resized
    if image.attached?
      image.variant(resize_to_limit: [223, 176]).processed
    else
      'cross.svg'
    end
  end

  def image_resized_for_purchase
    image.variant(resize_to_fill: [100, 100]).processed
  end
end
