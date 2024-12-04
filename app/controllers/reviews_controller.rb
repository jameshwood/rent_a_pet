class ReviewsController < ApplicationController
  def new
    @booking = Booking.find(params[:booking_id])
    @review = @booking.reviews.new
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = @booking.reviews.build(review_params)

    if @review.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
