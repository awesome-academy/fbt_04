class BookingTour < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  enum status: {start: 0, started: 1}
  delegate :name, to: :tour, prefix: :tour
end
