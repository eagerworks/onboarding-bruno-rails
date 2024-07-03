class Category < ApplicationRecord
  has_many :gift_categorizations
  has_many :gifts, through: :gift_categorizations
end
