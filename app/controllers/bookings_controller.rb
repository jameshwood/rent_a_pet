class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @made_bookings = current_user.bookings.includes(:animal)
    @received_bookings = current_user.received_bookings.includes(:user, :animal)
  end

  def new
    @animal = Animal.find(params[:animal_id])
    @booking = Booking.new()
  end

  def create
    @animal = Animal.find(params[:animal_id])
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      redirect_to bookings_path, notice: "Booking successful!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date_time, :end_date_time, :animal_id)
  end
end
