# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'faker'

puts "beginning database cleaning"
puts "destroying all reviews..."
Review.destroy_all
puts "destroying all rentals..."
Rental.destroy_all
puts "destroying all vans..."
Van.destroy_all
puts "destroying all users..."
User.destroy_all
# Need to work out how records are destroyed through other records
puts "database now clean"
puts "seeding the database"
puts "creating 5 users"
puts "@@@@@@@@@@@@@@@@@@@@"

5.times {
email = Faker::Internet.free_email #=> "freddy@gmail.com"
username = Faker::Internet.user_name('Nancy') #=> "nancy"
password = "password"
name = Faker::HarryPotter.character
name = name.split
first_name = name.first
last_name = name.last
# price = ((rand() * 100).round(0) + 20)
photo = "https://picsum.photos/200/300/?random"
User.create!({email: email, username: username, password: password, first_name: first_name,
  last_name: last_name, photo: photo})
puts "#{email} has been added to the db"
}

puts "user seeding created"
puts ""
puts "@@@@@@@@@@@@@@@@@@@@"
puts ""
puts "creating 5 vans"
puts ""

5.times {
  user_id = User.all.ids.sample
  location = Faker::Address.city #=> "Imogeneborough"
  availability = true
  photo = "https://picsum.photos/200/300/?random"
  make = Faker::Vehicle.manufacture
  model = "van"
  sleeps = Faker::Number.between(1, 4)
  bed = (sleeps / 2).round(0) + 1
  sleep = sleeps
  bathroom = true
  kitchen = true
  description = "A great little #{make} van that sleeps #{sleep} people - hire it for a great trip"
  price = (rand() * 100).round(0) + 20
  Van.create!({
    user_id: user_id, location: location, availability: availability,
    photo: photo, make: make, model: model, bed: bed, sleep: sleep,
    bathroom: bathroom, kitchen: kitchen, description: description, price: price
    })
  puts "#{make} has been added to the db"
}

puts ""
puts "van seeding completed"
puts ""
puts "@@@@@@@@@@@@@@@@@@@@"
puts ""
puts "creating 5 rentals"
puts ""

5.times {
  days_forward = (rand() * 100).round(0)
  days_rented = 7
  start_date = Faker::Time.forward(days_forward, :morning)
  end_date = Faker::Time.forward(days_forward + days_rented, :morning)
  photo = "https://picsum.photos/200/300/?random"
  price = ((rand() * 100).round(0) + 20)*3
  status = ["pending", "confirmed", "cancelled"].sample
  user_id = User.all.ids.sample
  van_id = Van.all.ids.sample
  Rental.create!({
    start_date: start_date, end_date: end_date, photo: photo, price: price,
    status: status, user_id: user_id, van_id: van_id})
  puts "A rental starting on #{start_date} ending on #{end_date} with a status of #{status} has been added to the db"
}

puts ""
puts "rental seeding completed"
puts ""
puts "@@@@@@@@@@@@@@@@@@@@"
puts ""
puts "creating 5 rentals"
puts ""

5.times {
  score = ((1..5).to_a).sample
  verb = ["terrible", "poor", "so so", "good", "amazing"]
  verb2 = ["rusty", "tired", "good enough", "so comfy", "super cool"]
  description = "I rented this van and had a #{verb} time. The van itself was #{verb2}"
  photo = "https://picsum.photos/200/300/?random"
  user_id = User.all.ids.sample
  van_id = Van.all.ids.sample
  Review.create!({score: score, description: description, photo: photo})
  puts "A review with a score of on #{score} has been added to the db"
}

puts ""
puts "review seeding completed"
puts ""
puts "@@@@@@@@@@@@@@@@@@@@"
puts ""
puts ""
puts ""
puts "all seeding compelted :-)"



