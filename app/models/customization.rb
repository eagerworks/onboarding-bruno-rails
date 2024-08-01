class Customization < ApplicationRecord
  has_many :gift_customizations, dependent: :destroy
  has_many :gifts, through: :gift_customizations
  has_and_belongs_to_many :purchases

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
