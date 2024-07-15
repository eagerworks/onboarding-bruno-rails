class Customization < ApplicationRecord
  has_many :gift_customizations
  has_many :gifts, through: :gift_customizations
  has_and_belongs_to_many :purchases
end
