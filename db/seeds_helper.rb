class SeedsHelper

  $pitch_point_hash_array = PitchPointsHelper.pitch_points_hash
  $scopes = DisclosureScopeHelper.scopes(nil)

  $valid=0
  $challid=1
  $enabid=2
  $solvid=3
  $facilid=4
  $survid=5

  def self.pitch_point_or_nil
    is_nil = (1 == rand(2))
    if is_nil
      return nil
    else
      pitch_point_length = PitchPointsHelper.pitch_point_max_length - 1
      return Faker::Lorem.characters(rand(90) + 1)
    end
  end

  def self.new_user(email, first_name, last_name)
    User.create!(:email => email, :password => 'password123', :first_name => first_name, :last_name => last_name)
  end

  def self.new_pcard(user, cdat, val, chall, enab, solv, facil, surv, img)

    if img
      pitch_card = PitchCard.new(image: File.new("#{Rails.root}/db/images/"+img))
    else
      pitch_card = PitchCard.new
    end

    pitch_card.created_at= cdat
    pitch_card.initiator = user

    pitch_card.status = :active

    pitch_card.i_scope = "public"
    pitch_card.c_scope = "public"

    pitch_card.inject_scopes($scopes)

    value = PitchPoint.new
    value.name = $pitch_point_hash_array[$valid][:name]
    value.selected = true
    value.value = val
    pitch_card.pitch_points << value

    if chall
      challenge = PitchPoint.new
      challenge.name = $pitch_point_hash_array[$challid][:name]
      challenge.selected = true
    end
    if chall and chall.length > 0
      challenge.value = chall
    end
    if chall
      pitch_card.pitch_points << challenge
    end

    if enab
      enable = PitchPoint.new
      enable.name = $pitch_point_hash_array[$enabid][:name]
      enable.selected = true
    end
    if enab and enab.length > 0
      enable.value = enab
    end
    if enab
      pitch_card.pitch_points << enable
    end

    if solv
      solve = PitchPoint.new
      solve.name = $pitch_point_hash_array[$solvid][:name]
      solve.selected = true
    end
    if solv and solv.length > 0
      solve.value = solv
    end
    if solv
      pitch_card.pitch_points << solve
    end

    if facil
      facilitate = PitchPoint.new
      facilitate.name = $pitch_point_hash_array[$facilid][:name]
      facilitate.selected = true
      facilitate.value = facil
      pitch_card.pitch_points << facilitate
    end

    if surv
      survey = PitchPoint.new
      survey.name = $pitch_point_hash_array[$survid][:name]
      survey.selected = true
      survey.value = surv
      pitch_card.pitch_points << survey
    end

    pitch_card.save
    return pitch_card
  end


  def  self.new_suggestion(pc,pp,u,cdat,comment, sugg, status, icscope)
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

end