class Booking < ApplicationRecord
  belongs_to :animal
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :start_date_time, :end_date_time, presence: true
end
