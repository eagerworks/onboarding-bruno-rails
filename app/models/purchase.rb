class Purchase < ApplicationRecord
  belongs_to :payment_method
  belongs_to :gift
  has_many :destinations
  accepts_nested_attributes_for :destinations
  has_and_belongs_to_many :customizations
  accepts_nested_attributes_for :customizations
  has_one_attached :company_logo

  delegate :price, :name, to: :gift, prefix: true
  delegate :name, to: :payment_method, prefix: true
  validates :destinations, length: { minimum: 1 }
  validates :personalization, :social_reason, :RUT, :destinations, presence: true

  def logo_resized
    company_logo.variant(resize_to_limit: [50, 25]).processed
  end
end
