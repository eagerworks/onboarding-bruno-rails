class Gift < ApplicationRecord
  has_many :gift_categorizations
  has_many :categories, through: :gift_categorizations
  has_many :gift_customizations
  has_many :customizations, through: :gift_customizations
  belongs_to :supplier
  delegate :name, to: :supplier, prefix: true
  has_one_attached :image
  has_rich_text :content

  scope :with_categories, lambda { |categories|
    joins(:gift_categorizations)
      .where(gift_categorizations: { category_id: categories })
  }

  def image_resized
    image.variant(resize_to_limit: [223, 176]).processed
  end
end
