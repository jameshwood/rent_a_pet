class BookingsController < ApplicationController

  def index
    # REPLACE JOHN WITH current_user
    @john = User.first
    @current_user = @john
    # same as current_user.bookings but makes one animal query for each user instead of several
    @made_bookings = @current_user.bookings.includes(:animal)
    # same here with query
    @received_bookings = @current_user.received_bookings.includes(:user, :animal)
  end
end
