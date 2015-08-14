module ActiveRecordAdaptable
  extend ActiveSupport::Concern

  def to_active_record_model(db_name)

    case self.class.name
      when 'PitchCard'
        result = self.to_active_record_pitch_card db_name
      when 'PitchPoint'
        result = self.to_active_record_pitch_point db_name
      when 'Comment'
        result = self.to_active_record_comment db_name
      when 'Suggestion'
        result = self.to_active_record_suggestion db_name
      else
        result = nil
    end

    result
  end

  # adapt methods
  def to_active_record_comment(db_name)

    ar_comment = ActiveRecordComment.using(db_name).new do |c|
      c.object_id = self.id.to_s
      c.pitch_card_id = self.pitch_card.id.to_s
      c.author_id = self.author.id.to_s
      c.message_type = self.message_type
      c.comment = self.comment
      c.author_name = self.author_name
      c.pitch_point_id = self.pitch_point_id
      c.pitch_point_name = self.pitch_point_name
      c.initiator_id = self.initiator_id.to_s
      c.identity_scope = self.identity_scope.class.name
      c.content_scope = self.content_scope.class.name
    end

    if self.initiator_content_scope.present?
      ar_comment.initiator_content_scope = self.initiator_content_scope._type
    end

    ar_comment

  end

  def to_active_record_suggestion(db_name)

    ar_suggestion = ActiveRecordSuggestion.using(db_name).new do |s|
      s.object_id = self.id.to_s
      s.pitch_card_id = self.pitch_card.id.to_s
      s.author_id = self.author.id.to_s
      s.message_type = self.message_type
      s.comment = self.comment
      s.content = self.content
      s.author_name = self.author_name
      s.pitch_point_id = self.pitch_point_id
      s.pitch_point_name = self.pitch_point_name
      s.initiator_id = self.initiator_id.to_s
      s.identity_scope = self.identity_scope.class.name
      s.content_scope = self.content_scope.class.name
    end

    if self.initiator_content_scope.present?
      ar_suggestion.initiator_content_scope = self.initiator_content_scope.class.name
    end

    ar_suggestion

  end

  def to_active_record_pitch_point(db_name)

    ar_pitch_point = ActiveRecordPitchPoint.using(db_name).new do |pp|
      pp.object_id = self.id.to_s
      pp.name = self.name
      pp.selected = self.selected
      pp.value = self.value
    end

    ar_pitch_point

  end

  def to_active_record_pitch_card(db_name)

    object_id = self.id.to_s
    initiator_id = self.initiator.id.to_s
    i_scope = self.identity_scope.class.name
    c_scope = self.content_scope.class.name

    pitch_card = ActiveRecordPitchCard.using(db_name).new do |pc|
      pc.identity_scope = i_scope
      pc.content_scope = c_scope
      pc.initiator_id = initiator_id
      pc.object_id = object_id
      pc.status = self.status
    end

    pitch_card

  end

  def save_pitch_points(db_name)

    object_id = self.id.to_s

    self.pitch_points.reject{|p| p.value.blank?}.each do |point|
      ar_point = point.to_active_record_model(db_name)
      ar_point.pitch_card_id = object_id
      ar_point.save
    end

  end

  module ClassMethods

    def active_record_class

      case self.name
        when 'PitchCard'
          result = ActiveRecordPitchCard
        when 'PitchPoint'
          result = ActiveRecordPitchPoint
        when 'Comment'
          result = ActiveRecordComment
        when 'Suggestion'
          result = ActiveRecordSuggestion
        else
          result = nil
      end

      result
    end

  end

end