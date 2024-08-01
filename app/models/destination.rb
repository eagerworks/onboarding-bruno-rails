class Destination < ApplicationRecord
  belongs_to :purchase
  validates :receiver, :schedules, :address, :number, :cost, presence: true
  validates :day, comparison: { greater_than: Date.today }
end
