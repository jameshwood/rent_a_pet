class Animal < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many :users, through: :bookings
  has_many_attached :photos
  validates :name, :species, :age, :price, :available_start, :available_end, presence: true
  validates :description, presence: true, length: { minimum: 12 }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  def average_rating
    return 0 if reviews.empty?
    (reviews.average(:rating).to_f * 2).round / 2.0
  end

  scope :available_for_dates, ->(from_date, to_date) {
    left_outer_joins(:bookings)
      .where(
        "bookings.start_date_time NOT BETWEEN ? AND ? AND bookings.end_date_time NOT BETWEEN ? AND ? OR bookings.id IS NULL",
        from_date, to_date, from_date, to_date
      )
  }
end
