class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.float :rating
      t.text :content
      t.references :bookings, null: false, foreign_key: true
      t.string :photos

      t.timestamps
    end
  end
end
