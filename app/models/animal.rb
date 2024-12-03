class Animal < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :users, through: :bookings
  validates :name, :species, :age, :price, :availability, :photos, presence: true
  validates :description, presence: true, length: { minimum: 12 }
end
