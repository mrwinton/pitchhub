# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'seeds_helper'


offset = 24069
number_of_users = 6000


def power_law(min,max,n)
  max += 1
  pl = ((max**(n+1) - min**(n+1))*rand() + min**(n+1))**(1.0/(n+1))
  (max-1-pl.to_i)+min
end

def generate_power_law_number
  power_law(0,10,1)
end

if Rails.env.test?
  puts "----------------------------------------------------------------"
  puts "Environment is TEST"
  puts "----------------------------------------------------------------"
  # puts "Cleaning the database"
  # DatabaseCleaner.strategy = :truncation
  # DatabaseCleaner.clean
  # puts "Database cleaning successful"
  # puts "----------------------------------------------------------------"
  # puts "Will seed " + number_of_users.to_s + " users..."
  # puts "----------------------------------------------------------------"
  # puts "Seeding users"
  #
  # number_of_users.times do |n|
  #   SeedsHelper.new_user(n.to_s + Faker::Internet.email, Faker::Name.first_name, Faker::Name.last_name)
  #   n = n+1
  #   puts "Seeded user[" + n.to_s + "]"
  # end
  #
  # puts number_of_users.to_s + " users seeded"
  puts "----------------------------------------------------------------"
  puts "Seeding Pitch Cards for each user"
  puts "----------------------------------------------------------------"
  index = 0

  start_time = Time.now
  end_time = start_time + 6.hours

  User.no_timeout.skip(offset).each do |user|
    puts "User[" + index.to_s + "] seeding"
    number_of_pitch_cards = generate_power_law_number
    puts "-- User[" + index.to_s + "] contributing " + number_of_pitch_cards.to_s + " Pitch Cards, id:[" + user._id + "]"

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

    if index == number_of_users or Time.now > end_time
      puts "Seeded " + index.to_s  + " users, exiting..."
      puts "New offset:  " + (index + offset).to_s
      break
    end

  end

else
  puts "Not in development"
end

