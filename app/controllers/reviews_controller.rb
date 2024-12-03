class ReviewsController < ApplicationController
  def index
    @booking = Booking.find(params[booking_id])
    @reviews = @booking.reviews
  end

  def new
    @review = Review.new
  end

  def create
    @booking = Booking.find(params[booking_id])
    @review = @booking.reviews.build(review_params)
    if @review.save
      flash[:notice] = "Your review has been created!"
      redirect_to booking_reviews_path(@booking)
    else
      render :new, status: unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
