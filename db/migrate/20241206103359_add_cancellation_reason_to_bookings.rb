class AddCancellationReasonToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :cancellation_reason, :string
  end
end
