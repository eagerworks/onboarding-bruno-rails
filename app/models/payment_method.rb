class PaymentMethod < ApplicationRecord
  belongs_to :user
  has_many :purchases

  validates :name, :owner, :card_number, :due_date, :CVV, presence: true
end
