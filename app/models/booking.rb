class Booking < ApplicationRecord
  belongs_to :animals, dependent: :destory
  belongs_to :users, dependent: :destory
  has_many :reviews
  validates :start_date_time, :end_date_time, presence: true
end
