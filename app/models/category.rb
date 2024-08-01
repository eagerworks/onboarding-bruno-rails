class Category < ApplicationRecord
  has_many :gift_categorizations, dependent: :destroy
  has_many :gifts, through: :gift_categorizations

  validates :name, presence: true
end
