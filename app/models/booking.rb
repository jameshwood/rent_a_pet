class Booking < ApplicationRecord
  belongs_to :animal, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_many :reviews
  validates :start_date_time, :end_date_time, presence: true
end
