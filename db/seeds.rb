# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "beginning database cleaning"
puts "destroying all users..."
User.destroy_all
puts "destroying all vans..."
Van.destroy_all

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

User.create!({email: email, username: username, password: password, first_name: first_name, last_name: last_name, photo: photo})

puts "#{email} has been added to the db"
}

puts "user seeding created"
puts ""

puts "@@@@@@@@@@@@@@@@@@@@"
puts ""

puts "creating 5 vans"

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
puts "user seeding created"
puts ""
puts "@@@@@@@@@@@@@@@@@@@@"
puts ""
puts "creating 5 rentals"

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
puts "user seeding created"
puts ""
puts "@@@@@@@@@@@@@@@@@@@@"
puts ""

    t.datetime "start_date"
    t.datetime "end_date"
    t.string "photo"
    t.integer "price"
    t.string "status"

