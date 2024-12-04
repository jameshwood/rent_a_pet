class AddAvailableDatesToAnimals < ActiveRecord::Migration[7.1]
  def change
    add_column :animals, :available_start, :date
    add_column :animals, :available_end, :date
  end
end
