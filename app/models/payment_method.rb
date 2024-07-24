class PaymentMethod < ApplicationRecord
  belongs_to :user
  has_many :purchases, dependent: :destroy

  validates :name, :owner, :card_number, :due_date, :CVV, presence: true
end
