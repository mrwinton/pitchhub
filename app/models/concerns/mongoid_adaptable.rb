module MongoidAdaptable
  extend ActiveSupport::Concern

  def to_mongoid_model(base_mongoid_model)

    case self.class.name
      when 'ActiveRecordPitchCard'
        result = self.to_mongoid_pitch_card base_mongoid_model
      when 'ActiveRecordPitchPoint'
        result = self.to_mongoid_pitch_point base_mongoid_model
      else
        result = nil
    end

    if result == nil
      if self.class.name == 'ActiveRecordSuggestion' || self.class.name == 'ActiveRecordComment'
        if self.discourse_type == 'comment'
          result = self.to_mongoid_comment base_mongoid_model
        elsif self.discourse_type == 'suggestion'
          result = self.to_mongoid_suggestion base_mongoid_model
        end
      end
    end

    result
  end

  # adapt methods
  def to_mongoid_comment(base_mongoid_comment)

    adapted_comment = base_mongoid_comment.dup

    adapted_comment.id = BSON::ObjectId.from_string(self.object_id)
    adapted_comment.comment = self.comment

    adapted_comment

  end

  def to_mongoid_suggestion(base_mongoid_suggestion)

    adapted_suggestion = base_mongoid_suggestion.dup

    adapted_suggestion.id = BSON::ObjectId.from_string(self.object_id)
    adapted_suggestion.comment = self.comment
    adapted_suggestion.content = self.content

    adapted_suggestion

  end

  def to_mongoid_pitch_point(base_mongoid_pitch_point)

    adapted_pitch_point = base_mongoid_pitch_point.dup

    adapted_pitch_point.id = BSON::ObjectId.from_string(self.object_id)
    adapted_pitch_point.value = self.value

    adapted_pitch_point

  end

  def to_mongoid_pitch_card(base_mongoid_pitch_card)

    shard = self.current_shard

    # get all pitch points with the pitch_card_id
    ar_pitch_points = ActiveRecordPitchPoint.using(shard).where(pitch_card_id: self.object_id)

    is_new = base_mongoid_pitch_card.new_record?

    adapted_pitch_card = base_mongoid_pitch_card.dup

    adapted_pitch_card.id = BSON::ObjectId.from_string(self.object_id)

    adapted_pitch_card.pitch_points.each do |point|

      ar_pitch_point = nil

      # there will be at least one pitch point due to value proposition
      ar_pitch_points.each do |ar_point|
        if ar_point.name == point.name
          ar_pitch_point = ar_point
          break
        end
      end

      if ar_pitch_point.present?
        point.value = ar_pitch_point.value
        point.id = BSON::ObjectId.from_string(ar_pitch_point.object_id)
        point.new_record = is_new
      end

    end

    adapted_pitch_card

  end

end