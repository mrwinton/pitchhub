# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pitch_cards_number = 100
max_suggestion = 10
max_comments = 10
$scopes = DisclosureScopeHelper.scopes(nil)

$valid=0
$challid=1
$enabid=2
$solvid=3
$facilid=4
$survid=5

def new_user(email, first_name, last_name)
  User.create!(:email => email, :password => 'password123', :first_name => first_name, :last_name => last_name, :access_code => 'PITCH2015')
end


def new_pcard(user, cdat, val, chall, enab, solv, facil, surv, img)
  pitch_point_hash_array = PitchPointsHelper.pitch_points_hash

  pitch_card = PitchCard.new(image: File.new("#{Rails.root}/db/images/"+img))
  pitch_card.created_at= cdat
  pitch_card.initiator = user
  
  pitch_card.status = :active

  pitch_card.i_scope = "public"
  pitch_card.c_scope = "public"

  pitch_card.inject_scopes($scopes)

  value = PitchPoint.new 
  value.name = pitch_point_hash_array[$valid][:name]
  value.selected = true
  value.value = val
  pitch_card.pitch_points << value
  
  if chall
     challenge = PitchPoint.new 
     challenge.name = pitch_point_hash_array[$challid][:name]
     challenge.selected = true
  end
  if chall.length > 0
     challenge.value = chall
  end
  if chall
      pitch_card.pitch_points << challenge
  end
  
  if enab
     enable = PitchPoint.new 
     enable.name = pitch_point_hash_array[$enabid][:name]
     enable.selected = true
  end
  if enab.length > 0
     enable.value = enab
  end
  if enab
      pitch_card.pitch_points << enable
  end

  if solv
     solve = PitchPoint.new 
     solve.name = pitch_point_hash_array[$solvid][:name]
     solve.selected = true
  end
  if solv.length > 0
     solve.value = solv
  end
  if solv
      pitch_card.pitch_points << solve
  end

  if facil
     facilitate = PitchPoint.new 
     facilitate.name = pitch_point_hash_array[$facilid][:name]
     facilitate.selected = true
     facilitate.value = fac
     pitch_card.pitch_points << facilitate
  end

  if surv
     survey = PitchPoint.new 
     survey.name = pitch_point_hash_array[$survid][:name]
     survey.selected = true
     survey.value = surv
     pitch_card.pitch_points << survey
  end

  pitch_card.save
  return pitch_card
end


def  new_suggestion(pc,pp,u,cdat,comment, sugg, status, icscope)
  pitch_point = pc.pitch_points[pp]
  suggestion = Suggestion.new

  suggestion.created_at= cdat

  suggestion.author = u
  suggestion.pitch_card = pc
  suggestion.comment = comment
  suggestion.content = sugg
  suggestion.author_name = u.first_name + " " + u.last_name
  suggestion.initiator_id = pc.initiator.id
  suggestion.pitch_point_id = pitch_point._id
  suggestion.pitch_point_name = pitch_point.name
  suggestion.message_type = :root

  suggestion.i_scope = "public"
  suggestion.c_scope = "public"
  suggestion.ic_scope = icscope

  if status == :accepted
      suggestion.status = :accepted

      pc.pitch_points_attributes = [
          { id: pitch_point._id, value: sugg }
      ]
     
 
  elsif status == :rejected
      suggestion.status = :rejected
  end

  suggestion.inject_scopes($scopes)

  suggestion.save
  pc.comments << suggestion
  pc.save
end


if Rails.env.test?
  puts "Environment is TEST"

  puts "Cleaning the database"
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
  puts "Database cleaning successful"

  puts "Will seed " + pitch_cards_number.to_s + " Pitch Cards..."
  puts "----------------------------------------------------------------"
  puts "Seeding users"
  user_a = User.create!(:email => 'michael@test.com',
                       :password => 'password123',
                       :first_name => 'Michael',
                       :last_name => 'Winton',
			:access_code => 'PITCH2015')

  puts "user_a created"

  user_b = User.create!(:email => 'pitchub@gmail.com',
                         :password => 'password',
                         :first_name => 'Pitch',
                         :last_name => 'Hub',
			 :access_code => 'PITCH2015')

  puts "user_b created"

  puts "----------------------------------------------------------------"
  puts "Seeding Pitch Cards"
  pitch_cards_number.times do |n|

    puts "Commencing Pitch Card " + n.to_s + " seed"

    initiator = (1 == rand(2) ? user_a : user_b)
    status = (1 == rand(2) ? :active : :complete)

    pitch_point_hash_array = PitchPointsHelper.pitch_points_hash

    pitch_point_value_proposition = pitch_point_hash_array.delete_at(0)

    pitch_card = PitchCard.new

    pitch_card.initiator = initiator
    pitch_card.status = status

    pitch_card.i_scope = "public"
    pitch_card.c_scope = "public"

    pitch_card.inject_scopes($scopes)

    value_proposition = PitchPoint.new
    value_proposition.name = pitch_point_value_proposition[:name]
    value_proposition.selected = true
    value_proposition_length = PitchPointsHelper.pitch_point_max_length - 1
    value_proposition.value = Faker::Lorem.characters(rand(value_proposition_length) + 1)

    pitch_card.pitch_points << value_proposition

    number_of_pitch_points = rand(pitch_point_hash_array.length)

    number_of_pitch_points.times do |o|

      pitch_point_hash = pitch_point_hash_array[o]

      pitch_point = PitchPoint.new

      pitch_point.name = pitch_point_hash[:name]
      pitch_point.selected = true
      value_length = PitchPointsHelper.pitch_point_max_length - 1
      pitch_point.value = Faker::Lorem.characters(rand(value_length) + 1)

      pitch_card.pitch_points << pitch_point

    end

    has_suggestions = (1 == rand(2) ? true : false)
    has_comments = (1 == rand(2) ? true : false)

    if has_comments

      number_of_comments = rand(max_comments)

      number_of_comments.times do |p|

        pitch_point = pitch_card.pitch_points[rand(pitch_card.pitch_points.length)]

        comment = Comment.new

        comment.author = (1 == rand(2) ? user_a : user_b)
        comment.pitch_card = pitch_card
        comment_length = DiscoursesHelper.comment_max_length - 1
        comment.comment = Faker::Lorem.characters(rand(comment_length) + 1)
        comment.author_name = Faker::Name.name
        comment.initiator_id = initiator.id
        comment.pitch_point_id = pitch_point.id
        comment.pitch_point_name = pitch_point.name
        comment.message_type = :root

        comment.i_scope = "public"
        comment.c_scope = "public"

        comment.inject_scopes($scopes)

        if comment.save
          puts " +--> Successfully added comment to Pitch Card " + n.to_s
          pitch_card.comments << comment
        else
          puts " +--> Unsuccessfully added comment to Pitch Card " + n.to_s
        end

        pitch_card.comments << comment
      end

    end

    if has_suggestions

      number_of_suggestions = rand(max_suggestion)

      number_of_suggestions.times do |p|

        pitch_point = pitch_card.pitch_points[rand(pitch_card.pitch_points.length)]

        suggestion = Suggestion.new

        suggestion.author = (1 == rand(2) ? user_a : user_b)
        suggestion.pitch_card = pitch_card
        suggestion_length = DiscoursesHelper.comment_max_length - 1
        suggestion.comment = Faker::Lorem.characters(rand(suggestion_length) + 1)
        content_length = PitchPointsHelper.pitch_point_max_length - 1
        suggestion.content = Faker::Lorem.characters(rand(content_length) + 1)
        suggestion.author_name = Faker::Name.name
        suggestion.initiator_id = initiator.id
        suggestion.pitch_point_id = pitch_point._id
        suggestion.pitch_point_name = pitch_point.name
        suggestion.message_type = :root

        suggestion.i_scope = "public"
        suggestion.c_scope = "public"

        suggestion.inject_scopes($scopes)

        if suggestion.save
          puts " +--> Successfully added suggestion to Pitch Card " + n.to_s
          pitch_card.comments << suggestion
        else
          puts " +--> Unsuccessfully added suggestion to Pitch Card " + n.to_s
        end

      end

    end

    if pitch_card.save
      puts "Successful Pitch Card " + n.to_s + " seed"
    else
      puts "Unsuccessful Pitch Card " + n.to_s + " seed"
    end

  end

  puts pitch_cards_number.to_s + " Pitch Cards seeded"

else

  puts "Environment is NOT TEST, seeding historic cards."

  # DatabaseCleaner.strategy = :truncation
  # DatabaseCleaner.clean

  # user_gn = new_user('erdbirne@gmail.com', 'Gregor','Neumayr')
  user_hd = new_user('hd@test.com','Humphrey','Davy')
  user_js = new_user('js@test.com','Sir Joseph', 'Swan')
  user_ke = new_user('ke@test.com','King Edward','VII')
  user_te = new_user('te@test.com','Thomas','Edison')

  pitch_card = new_pcard(user_hd, '03-03-1815', 'electric light - lights up the night',
     'develop a principle for an electrical light',
     '','discharge a battery via carbon electrodes to create an arc', nil, nil, 'swan-lamp.jpg')

  new_suggestion(pitch_card, $challid, user_js, '01-09-1860',
    'I think we need to develop an electrical light bulb that is much more practical and long-lasting than the arc light bulb',
    'devise a practical, long-lasting electric light', :accepted, 'public')

  new_suggestion(pitch_card, $solvid, user_js, '01-09-1875',
    'After some testing, I will suggest to use carbonized paper filaments. They gave me the best results so far. Also, If we enclose it in a vacuum glass bulb, there is less oxygen available and the filament lasts much longer.',
    'use carbonized paper filament in a vacuum bulb', :accepted, 'public')

  new_suggestion(pitch_card, $challid, user_te, '01-08-1878', 
    'The stuff that Swan did is quite nice, but I suggest we put down some real money and develop a complete integrated system. Whatever comes out of that, I will certainly claim all credit for myself. At least in the US of America',
    'develop an entire, integrated system of electric lighting', :accepted, 'members')
 
  new_suggestion(pitch_card, $enabid, user_js, '01-09-1878',
    'I got the resources to do a rigorous screening to identify the best filament material. Also, I can afford the vacuum pump that Hermann Sprengel invented in 1865.',
    'the first industrial research ogranisation in Manlo Park can perform screening for best material',:accepted, 'members')

  new_suggestion(pitch_card, $solvid, user_ke, '27-12-1903', 'I like oldscool. Use candles instead of burning coal to generate electricity to produce light and heat', 'use a candle', :rejected, 'initiator') 

  new_suggestion(pitch_card, $solvid, user_te, '27-12-1889', 'We performed a screening and now we know it: Bamboo is hat we want. I like oldscool.', 'bamboo filament in a vacuum bulb', :accepted, 'members') 

  pitch_card.save

  puts "----------------------------------------------------------------"


  user_as = new_user('as@test.com','Archimedes','of Syracuse')
  user_bh = new_user('bh@test.com','Bill','Hamilton')
  user_af = new_user('af@test.com','Arnold','Franze')
  user_ae = new_user('ae@test.com','anonymous', 'Employee')
  user_gd = new_user('gd@test.com','George', 'Davison')
  user_om = new_user('om@test.com','Otis "Dock"','Marston')

  date = Date.today - 2227.years
  pitch_card = new_pcard(user_as, date, 'transport material against gravity',
     '','','use a screw to translate rotary motion into linear motion for transportation',
      nil, 'is this useful to you?', 'archimedes-screw.jpg')

  pitch_card = new_pcard(user_bh, '05-03-1953', 'fast travel on shallow water',
     'design a hull suitable for a river craft and a replacement for the propeller',
     'funds and workers available','',
      nil, nil, 'hamilton-jet.jpg')
  
  new_suggestion(pitch_card, $solvid, user_af, '06-04-1953', 
     'Hey Bill, I suggest you look into jet engines like the one Hanley designed. I cal loan you a US Pamphlet with details.', 
    'use Hanley Jet', :accepted, 'members') 

  new_suggestion(pitch_card, $solvid, user_ae, '06-04-1955', 
    'We should eliminate all parts of the design that protrude below the hull exposed to damage. I got the idea from a high pressure firehose..',
    'integrate jet into the hull', :accepted, 'members') 

  new_suggestion(pitch_card, $solvid, user_gd, '06-07-1956', 
    'this can be a breakthrough',
    'use two stage axial flow unit', :accepted, 'members') 

  new_suggestion(pitch_card, $challid, user_om, '04-06-1960', 
    'I can offer to do the planning and logistics for this. We are going to need 2500 tons of fuel',
    'go up the grand canyon in three jet boats as a demo',
    :accepted, 'members')

  pitch_card.save

  puts "----------------------------------------------------------------"

  user_ah = new_user('ah@test.com','August Wilhelm','von Hofmann') 
  user_wp = new_user('wp@test.com','William Henry','Perkin') 

  pitch_card = new_pcard(user_as, date, 'A cure for Malaria',
     'find a way to synthesize Quinine','I offer a study place at the Royal College of Chemistry in London','',
      nil, nil, 'malaria.jpg')

  new_suggestion(pitch_card, $challid, user_wp, '04-06-1960', 
    'I can offer to do the planning and logistics for this. We are going to need 2500 tons of fuel',
    'go up the grand canyon in three jet boats as a demo',
    :accepted, 'members')
  

  puts "----------------------------------------------------------------"

  pitch_card = new_pcard(user_as, date, 'transport material against gravity',
     '','','use a screw to translate rotary motion into linear motion for transportation',
      nil, 'is this useful to you?', 'ford-t.jpg')

  pitch_card = new_pcard(user_as, date, 'transport material against gravity',
     '','','use a screw to translate rotary motion into linear motion for transportation',
      nil, 'is this useful to you?', 'wheel.jpg')


  puts "Seeding Pitch Cards"

end
