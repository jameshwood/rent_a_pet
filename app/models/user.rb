class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :animals
  has_many :bookings, through: :animals, as: :received_bookings
  has_many :reviews, through: :bookings
  has_many :bookings
  has_many :animals, through: :bookings, as: :booked_animals
  validates :first_name, :last_name, :info, :email, presence: true
end
