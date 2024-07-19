class Destination < ApplicationRecord
  belongs_to :purchase
  validates :receiver, :day, :schedules, :address, :number, :cost, presence: true
end
