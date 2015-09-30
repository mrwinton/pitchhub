# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'seeds_helper'
puts "HEY"

number_of_users = 10

def power_law(min,max,n)
  max += 1
  pl = ((max**(n+1) - min**(n+1))*rand() + min**(n+1))**(1.0/(n+1))
  (max-1-pl.to_i)+min
end

def generate_power_law_number
  power_law(0,80,1)
end

if Rails.env.development?
  puts "----------------------------------------------------------------"
  puts "Environment is DEVELOPMENT"
  puts "----------------------------------------------------------------"
  # puts "Cleaning the database"
  # DatabaseCleaner.strategy = :truncation
  # DatabaseCleaner.clean
  # puts "Database cleaning successful"
  puts "----------------------------------------------------------------"
  puts "Will seed " + number_of_users.to_s + " users..."
  puts "----------------------------------------------------------------"
  puts "Seeding users"

  number_of_users.times do |n|
    SeedsHelper.new_user(Faker::Internet.email, Faker::Name.first_name, Faker::Name.last_name)
    n = n+1
    puts "Seeded user[" + n.to_s + "]"
  end

  puts number_of_users.to_s + " users seeded"
  puts "----------------------------------------------------------------"
  puts "Seeding Pitch Cards for each user"
  puts "----------------------------------------------------------------"
  index = 0

  User.each do |user|
    puts "User[" + index.to_s + "] seeding"
    number_of_pitch_cards = generate_power_law_number
    puts "-- User[" + user._id + "] contributing " + number_of_pitch_cards.to_s + " Pitch Cards"

    number_of_pitch_cards.times do |n|

      value_proposition_length = PitchPointsHelper.pitch_point_max_length - 1
      value_proposition = Faker::Lorem.characters(rand(value_proposition_length) + 1)

      SeedsHelper.new_pcard(user, Faker::Date.between(2.years.ago, Date.today), value_proposition,
                SeedsHelper.pitch_point_or_nil,SeedsHelper.pitch_point_or_nil, SeedsHelper.pitch_point_or_nil,
                SeedsHelper.pitch_point_or_nil, SeedsHelper.pitch_point_or_nil, nil)

      puts "-- -- User[" + user._id + "] contributed " + n.to_s + " Pitch Card"
    end
    index = index + 1
    puts "User[" +index.to_s+ "] seeded"
    puts " "
  end

else
  puts "Not in development"
end

