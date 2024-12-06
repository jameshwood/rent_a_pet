class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_animal, only: [:new, :create]
  before_action :set_booking, only: [:show, :destroy]
  before_action :authorize_user, only: [:new, :create]

  def index
    @made_bookings = current_user.bookings.includes(:animal)
    @received_bookings = current_user.received_bookings.includes(:user, :animal)
  end

  def new
    @booking = Booking.new()
  end


  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      redirect_to bookings_path, notice: "Booking successful!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @booking.destroy
    flash[:notice] = "Booking was successfully cancelled."
    redirect_to bookings_path, status: :see_other
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: "Booking updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def set_booking
    @booking = Booking.includes(:animal).find(params[:id])
  end

  def authorize_user
    @animal = Animal.find(params[:animal_id])
    if @animal.user == current_user
      redirect_to animal_path(@animal), alert: "You can't book your own listing!"
    end
  end

  def booking_params
    params.require(:booking).permit(:start_date_time, :end_date_time, :animal_id)
  end
end
