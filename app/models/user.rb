class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :animals, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many :bookings
  has_many :received_bookings, through: :animals, source: :bookings
  has_many :booked_animals, through: :bookings, source: :animal
  validates :first_name, :last_name, :info, :email, presence: true
end
