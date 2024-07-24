class Purchase < ApplicationRecord
  belongs_to :payment_method
  has_one :user, through: :payment_method
  belongs_to :gift
  has_many :destinations, dependent: :destroy
  accepts_nested_attributes_for :destinations
  has_and_belongs_to_many :customizations
  accepts_nested_attributes_for :customizations
  has_one_attached :company_logo

  validates :amount, numericality: { greater_than: 0 }
  validates :destinations, length: { minimum: 1 }
  validates :personalization, :amount, :social_reason, :RUT, :destinations, :payment_method,
            presence: true

  delegate :price, :name, to: :gift, prefix: true
  delegate :name, to: :payment_method, prefix: true
  delegate :email, to: :user, prefix: true

  def price
    subtotal + (subtotal * 0.22).to_i + 180
  end

  def subtotal
    customizations_cost = customizations.map(&:price).sum.to_i
    (gift_price + customizations_cost) * amount
  end

  def logo_resized
    company_logo.variant(resize_to_limit: [50, 25]).processed
  end
end
