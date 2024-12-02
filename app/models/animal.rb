class Animal < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many :users, through: :bookings
  has_many_attached :photos
  validates :name, :species, :age, :price, :availability, :photos, presence: true
  validates :description, presence: true, length: { minimum: 12 }

  attr_accessor :available_start, :available_end

  def average_rating
    return 0 if reviews.empty?
    (reviews.average(:rating).to_f * 2).round / 2.0
  end
end
