class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.references :animals, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
