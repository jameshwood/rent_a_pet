class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @made_bookings = current_user.bookings.includes(:animal)
    @received_bookings = current_user.received_bookings.includes(:user, :animal)
  end

  def show
    @booking = Booking.includes(:animal).find(params[:id])
  end

end
