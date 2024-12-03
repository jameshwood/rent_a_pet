# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
# Clear existing data (order matters to handle dependencies)


# Clear existing data


# Create users
user1 = User.create!(first_name: "John", last_name: "Doe", info: "Loves animals and nature.", email: "john.doe@example.com", password: "password123")
user2 = User.create!(first_name: "Jane", last_name: "Smith", info: "Cat enthusiast.", email: "jane.smith@example.com", password: "password123")
user3 = User.create!(first_name: "Emily", last_name: "Brown", info: "Fosters rescue animals.", email: "emily.brown@example.com", password: "password123")
user4 = User.create!(first_name: "Chris", last_name: "Johnson", info: "Dog trainer by profession.", email: "chris.johnson@example.com", password: "password123")
user5 = User.create!(first_name: "Alex", last_name: "Taylor", info: "Animal shelter volunteer.", email: "alex.taylor@example.com", password: "password123")

# Create animals
animal1 = Animal.create!(user: user1, name: "Buddy", species: "dog", age: 3, price: 50, availability: true, photos: ["https://via.placeholder.com/150"], description: "A friendly Labrador.")
animal2 = Animal.create!(user: user2, name: "Whiskers", species: "cat", age: 2, price: 30, availability: true, photos: ["https://via.placeholder.com/150"], description: "A playful tabby cat.")
animal3 = Animal.create!(user: user3, name: "Hopper", species: "rabbit", age: 1, price: 20, availability: true, photos: ["https://via.placeholder.com/150"], description: "An adorable bunny.")
animal4 = Animal.create!(user: user4, name: "Rocky", species: "dog", age: 5, price: 60, availability: true, photos: ["https://via.placeholder.com/150"], description: "An energetic German Shepherd.")
animal5 = Animal.create!(user: user5, name: "Chirpy", species: "bird", age: 1, price: 15, availability: true, photos: ["https://via.placeholder.com/150"], description: "A cheerful parakeet.")

# Create bookings
booking1 = Booking.create!(animal: animal1, user: user2, start_date_time: Time.now + 5.days, end_date_time: Time.now + 10.days)
booking2 = Booking.create!(animal: animal2, user: user3, start_date_time: Time.now + 2.days, end_date_time: Time.now + 7.days)
booking3 = Booking.create!(animal: animal3, user: user4, start_date_time: Time.now + 1.days, end_date_time: Time.now + 3.days)
booking4 = Booking.create!(animal: animal4, user: user5, start_date_time: Time.now + 4.days, end_date_time: Time.now + 8.days)
booking5 = Booking.create!(animal: animal5, user: user1, start_date_time: Time.now + 3.days, end_date_time: Time.now + 6.days)

# Create reviews
Review.create!(booking: booking1, content: "Wonderful experience, highly recommend!", rating: 9)
Review.create!(booking: booking2, content: "Very well-behaved and lovely.", rating: 8)
Review.create!(booking: booking3, content: "Charming little rabbit, had a great time.", rating: 10)
Review.create!(booking: booking4, content: "Rocky was so energetic and playful!", rating: 7)
Review.create!(booking: booking5, content: "Chirpy was delightful to have around.", rating: 8)

puts "Seeding complete! Created #{User.count} users, #{Animal.count} animals, #{Booking.count} bookings, and #{Review.count} reviews."
