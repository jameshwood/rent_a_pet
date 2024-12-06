# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
# Clear existing data (order matters to handle dependencies)


# Clear existing data
User.destroy_all
Animal.destroy_all
Booking.destroy_all
Review.destroy_all

# Common password for all seeded users
password = "password123"

# Seed Users
users = []
i = 0
7.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  users << User.create!(
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: password,
    password_confirmation: password,
    first_name: first_name,
    last_name: last_name,
    avatar: Faker::Avatar.image,
    info: Faker::Lorem.paragraph
  )
end

puts "Seeded #{users.size} users."

# Seed Animals

predefined_animals = [
  { name: "Whiskers", species: "Cat", age: 3, description: "A friendly, playful cat who loves naps and chasing small toys.", price: 100, address: "Falkensee, Berlin", available_start: "2024-12-01", available_end: "2025-02-28" },
  { name: "Mittens", species: "Cat", age: 8, description: "Loves to cuddle, nap all day, and chase fluffy string toys.", price: 120, address: "Oxford Street, London", available_start: "2024-12-05", available_end: "2025-02-15" },
  { name: "Luna", species: "Cat", age: 2, description: "Curious explorer who enjoys climbing furniture and watching birds outside.", price: 90, address: "Vallecas, Madrid", available_start: "2024-12-15", available_end: "2025-02-10" },

  { name: "Buddy", species: "Dog", age: 4, description: "A loyal companion, loves long walks, and fetch games in parks.", price: 150, address: "C. Rosas, Madrid", available_start: "2024-12-03", available_end: "2025-02-20" },
  { name: "Max", species: "Dog", age: 6, description: "Energetic, great with kids, enjoys hiking and swimming during summer days.", price: 180, address: "Kurfürstendamm, Berlin", available_start: "2024-12-10", available_end: "2025-02-25" },
  { name: "Bella", species: "Dog", age: 2, description: "Gentle, playful, enjoys belly rubs, and loves following owners everywhere.", price: 160, address: "Southall, London", available_start: "2024-12-20", available_end: "2025-02-18" },

  { name: "Thumper", species: "Rabbit", age: 1, description: "Fluffy and active rabbit, enjoys carrots and exploring the garden daily.", price: 50, address: "Coslada, Madrid", available_start: "2024-12-01", available_end: "2025-02-15" },
  { name: "Coco", species: "Rabbit", age: 2, description: "Calm, enjoys hopping, chewing toys, and sitting quietly beside owners often.", price: 60, address: "Avenue des Champs-Élysées, Paris", available_start: "2024-12-10", available_end: "2025-02-25" },
  { name: "Snowball", species: "Rabbit", age: 3, description: "Friendly rabbit, loves attention, enjoys nibbling hay and occasional treats.", price: 55, address: "Brandenburger Tor, Berlin", available_start: "2024-12-15", available_end: "2025-02-10" },

  { name: "Tweety", species: "Bird", age: 2, description: "A cheerful bird who sings daily, loves flying and perching indoors.", price: 40, address: "Marais, Paris", available_start: "2024-12-05", available_end: "2025-02-28" },
  { name: "Rio", species: "Bird", age: 1, description: "Colorful parrot who mimics sounds and enjoys chirping throughout sunny days.", price: 50, address: "Calle de Alcalá, Madrid", available_start: "2024-12-15", available_end: "2025-02-15" },
  { name: "Sky", species: "Bird", age: 3, description: "Graceful and energetic, loves soaring indoors and eating seeds, berries.", price: 45, address: "Paseo del Prado, Madrid", available_start: "2024-12-01", available_end: "2025-02-20" },

  { name: "Spirit", species: "Horse", age: 7, description: "Majestic, strong horse, enjoys galloping freely and interacting with kind humans.", price: 500, address: "Baker Street, London", available_start: "2024-12-01", available_end: "2025-02-28" },
  { name: "Shadow", species: "Horse", age: 12, description: "Gentle riding horse, loves being groomed and running across open fields.", price: 550, address: "Unter den Linden, Berlin", available_start: "2024-12-15", available_end: "2025-02-25" },
  { name: "Blaze", species: "Horse", age: 10, description: "Fast, energetic horse, enjoys jumping obstacles and grazing on fresh grass.", price: 600, address: "Rue de Rivoli, Paris", available_start: "2024-12-10", available_end: "2025-02-28" },

  { name: "Slither", species: "Snake", age: 3, description: "Calm, beginner-friendly snake, loves basking under heat lamps and hiding.", price: 200, address: "Rue d'Aboukir, Paris", available_start: "2024-12-01", available_end: "2025-02-15" },
  { name: "Venom", species: "Snake", age: 5, description: "Exotic snake, requires care and enjoys curling under rocks in tanks.", price: 250, address: "Calle Serrano, Madrid", available_start: "2024-12-05", available_end: "2025-02-20" },

  { name: "Shelly", species: "Turtle", age: 15, description: "Slow turtle, enjoys relaxing in water and eating lettuce, small fruits.", price: 70, address: "Buckingham Palace, London", available_start: "2024-12-10", available_end: "2025-02-25" },
  { name: "Crush", species: "Turtle", age: 20, description: "Friendly turtle, great with kids, loves basking and eating leafy vegetables.", price: 80, address: "Kurfürstendamm, Berlin", available_start: "2024-12-15", available_end: "2025-02-28" },
  { name: "Sonic", species: "Hedgehog", age: 2, description: "Adorable hedgehog, loves exploring, rolling into balls, and playing quietly.", price: 90, address: "Gran Vía, Madrid", available_start: "2024-12-01", available_end: "2025-02-15" }
]

users = User.all.to_a

animals = []

predefined_animals.each_with_index do |animal_data, index|

  user = users[index % users.size]

  animal = Animal.create!(
    name: animal_data[:name],
    species: animal_data[:species],
    age: animal_data[:age],
    description: animal_data[:description],
    price: animal_data[:price],
    address: animal_data[:address],
    available_start: animal_data[:available_start],
    available_end: animal_data[:available_end],
    user_id: user.id,
    availability: Date.today >= Date.parse(animal_data[:available_start]) && Date.today <= Date.parse(animal_data[:available_end])
  )

  3.times do |i|
    photo_path = Rails.root.join("app/assets/images/animals/#{animal_data[:name].downcase.gsub(' ', '_')}_#{i + 1}.jpg")
    if File.exist?(photo_path)
      animal.photos.attach(
        io: File.open(photo_path),
        filename: "#{animal_data[:name].downcase.gsub(' ', '_')}_#{i + 1}.jpg",
        content_type: "image/jpeg"
      )
    else
      puts "Photo for #{animal_data[:name]} (#{i + 1}) not found at #{photo_path}"
    end
  end

  animals << animal

end

puts "Seeded #{Animal.count} animals."


# Seed Bookings
animals.each do |animal|
  2.times do
    user = users.reject { |u| u.id == animal.user_id }.sample

    start_date = Faker::Date.between(from: Date.today, to: Date.today + 3.months)
    end_date = start_date + rand(5..15).days

    Booking.create!(
      start_date_time: start_date,
      end_date_time: end_date,
      animal_id: animal.id,
      user_id: user.id
    )
  end
end

users.each do |user|
  bookings_for_user = Booking.where(user_id: user.id)

  while bookings_for_user.size < 2
    animal = animals.reject { |a| a.user_id == user.id }.sample

    start_date = Faker::Date.between(from: Date.today, to: Date.today + 3.months)
    end_date = start_date + rand(5..15).days

    Booking.create!(
      start_date_time: start_date,
      end_date_time: end_date,
      animal_id: animal.id,
      user_id: user.id
    )

    bookings_for_user = Booking.where(user_id: user.id)
  end
end

puts "Seeded #{Booking.count} bookings."

# Seed Reviews
animals.each do |animal|
  bookings_for_animal = Booking.where(animal_id: animal.id).limit(2)

  bookings_for_animal.each_with_index do |booking, index|
    if index == 0
      rating = rand(6..10)
      content = "Renting #{animal.name} was a great experience! I would definitely recommend it to others."
    else
      rating = rand(4..7)
      content = "The experience with #{animal.name} was ok."
    end

    Review.create!(
      rating: rating,
      content: content,
      booking_id: booking.id
    )
  end
end

puts "Seeded #{Review.count} reviews."

puts "Seeding complete! Created #{User.count} users, #{Animal.count} animals, #{Booking.count} bookings, and #{Review.count} reviews."
