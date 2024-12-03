class Animal < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :users, through: :bookings
  validates :name, :species, :age, :price, :availability, :photos, presence: true
  validates :description, presence: true, length: { minimum: 12 }

  def average_rating
    return 0 if reviews.empty?
    (reviews.average(:rating).to_f * 2).round / 2.0
  end
end
