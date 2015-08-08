module ActiveRecordAdaptable
  extend ActiveSupport::Concern

  def to_active_record_model

    case self.class.name
      when 'PitchCard'
        result = self.to_active_record_pitch_card
      when 'PitchPoint'
        result = self.to_active_record_pitch_point
      when 'Comment'
        result = self.to_active_record_comment
      when 'Suggestion'
        result = self.to_active_record_suggestion
      else
        result = nil
    end

    result
  end

  def update_from(other_ar_model)

    case self.class.name
      when 'PitchCard'
        result = self.update_pitch_card other_ar_model
      when 'PitchPoint'
        result = self.update_pitch_point other_ar_model
      when 'Comment'
        result = self.update_comment other_ar_model
      when 'Suggestion'
        result = self.update_suggestion other_ar_model
      else
        result = nil
    end

    result
  end

  # adapt methods
  def to_active_record_comment

    ar_comment = ActiveRecordComment.new do |c|
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

    unless self.new_record?
      ar_comment.new_record = false
    end

    ar_comment

  end

  def to_active_record_suggestion

    ar_suggestion = ActiveRecordSuggestion.new do |s|
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

    unless self.new_record?
      ar_suggestion.new_record = false
    end

    ar_suggestion

  end

  def to_active_record_pitch_point

    ar_pitch_point = ActiveRecordPitchPoint.new do |pp|
      pp.object_id = self.id.to_s
      pp.name = self.name
      pp.selected = self.selected
      pp.value = self.value
    end

    unless self.new_record?
      ar_pitch_point.new_record = false
    end

    ar_pitch_point

  end

  def to_active_record_pitch_card

    object_id = self.id.to_s
    initiator_id = self.initiator.id.to_s
    i_scope = self.identity_scope.class.name
    c_scope = self.content_scope.class.name

    pitch_card = ActiveRecordPitchCard.new do |pc|
      pc.identity_scope = i_scope
      pc.content_scope = c_scope
      pc.initiator_id = initiator_id
      pc.object_id = object_id
      pc.status = self.status
    end

    unless self.new_record?
      pitch_card.new_record = false
    end

    self.pitch_points.reject{|p| p.value.blank?}.each do |point|
      ar_point = point.to_active_record_model
      ar_point.save
    end

    pitch_card

  end

  # update methods
  def update_comment(other_comment)

    if self.comment != other_comment.comment
      other_comment.comment = self.comment
    end

    if self.identity_scope != other_comment.identity_scope
      other_comment.identity_scope = self.identity_scope
    end

    if self.content_scope != other_comment.content_scope
      other_comment.content_scope = self.content_scope
    end

  end

  def update_suggestion(other_suggestion)

    if self.comment != other_suggestion.comment
      other_suggestion.comment = self.comment
    end

    if self.content != other_suggestion.content
      other_suggestion.content = self.content
    end

    if self.identity_scope != other_suggestion.identity_scope
      other_suggestion.identity_scope = self.identity_scope
    end

    if self.content_scope != other_suggestion.content_scope
      other_suggestion.content_scope = self.content_scope
    end

  end

  def update_pitch_point(other_pitch_point)

    if self.value != other_pitch_point.value
      other_pitch_point.value = self.value
    end

  end

  def update_pitch_card(other_pitch_card)

    if self.identity_scope != other_pitch_card.identity_scope
      other_pitch_card.identity_scope = self.identity_scope
    end

    if self.content_scope != other_pitch_card.content_scope
      other_pitch_card.content_scope = self.content_scope
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