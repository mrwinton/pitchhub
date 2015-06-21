class PitchPointValidator < ActiveModel::Validator

  def validate(pitch_point)

    # retrieve the corresponding PitchPoint Hash containing the options
    pitch_point_hash = PitchPointsHelper.pitch_points_hash.select { |point|
      pitch_point.name == point[:name]
    }
    pitch_point_hash = pitch_point_hash.any? ? pitch_point_hash.first : nil

    # the pitch point must be specified in our pitch_point_hash
    if pitch_point_hash == nil
      pitch_point.errors[:base] << pitch_point.name + ' is not recognised! Please select a valid Pitch Point.'
    end

    # check that non-optional PitchPoints are selected
    if pitch_point_hash[:optional] == false and pitch_point.selected == false
      pitch_point.errors[:base] << pitch_point.name + ' is not optional!'
    end

    # check that non-optional PitchPoints have a value
    if pitch_point_hash[:optional] == false and pitch_point.value.empty?
      pitch_point.errors[:base] << pitch_point.name + ' cannot be empty!'
    end

    # check that the PitchPoint value is within the character limit (if it exists)
    if pitch_point.value?
      if pitch_point.value.length > PitchPointsHelper.pitch_point_max_length
        pitch_point.errors[:base] << 'Must be ' + PitchPointsHelper.pitch_point_max_length + ' characters or less!'
      end
    end

  end

end