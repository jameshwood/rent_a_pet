class CreateAnimals < ActiveRecord::Migration[7.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :species
      t.integer :age
      t.text :description
      t.string :breed
      t.float :price
      t.boolean :availability
      t.references :user, null: false, foreign_key: true
      t.string :photos

      t.timestamps
    end
  end
end
