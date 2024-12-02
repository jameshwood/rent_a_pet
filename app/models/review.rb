class Review < ApplicationRecord
  belongs_to :bookings
  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: 0..10 }
end
