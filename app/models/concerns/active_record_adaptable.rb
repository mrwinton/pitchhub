module ActiveRecordAdaptable
  extend ActiveSupport::Concern

  def self.active_record_class

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

  private

  # adapt methods
  def to_active_record_comment

    ar_comment = ActiveRecordComment.new

    ar_comment.object_id = self.id.to_s
    ar_comment.pitch_card_id = self.pitch_card.id.to_s
    ar_comment.author_id = self.author.id.to_s
    ar_comment.message_type = self.message_type
    ar_comment.comment = self.comment
    ar_comment.author_name = self.author_name
    ar_comment.pitch_point_id = self.pitch_point_id
    ar_comment.pitch_point_name = self.pitch_point_name
    ar_comment.initiator_id = self.initiator_id.to_s
    ar_comment.identity_scope = self.identity_scope.class.name
    ar_comment.content_scope = self.content_scope.class.name

    if self.initiator_content_scope.present?
      ar_comment.initiator_content_scope = self.initiator_content_scope._type
    end

    unless self.new_record?
      ar_comment.new_record = false
    end

  end

  def to_active_record_suggestion

    ar_suggestion = ActiveRecordSuggestion.new

    ar_suggestion.object_id = self.id.to_s
    ar_suggestion.pitch_card_id = self.pitch_card.id.to_s
    ar_suggestion.author_id = self.author.id.to_s
    ar_suggestion.message_type = self.message_type
    ar_suggestion.comment = self.comment
    ar_suggestion.content = self.content
    ar_suggestion.author_name = self.author_name
    ar_suggestion.pitch_point_id = self.pitch_point_id
    ar_suggestion.pitch_point_name = self.pitch_point_name
    ar_suggestion.initiator_id = self.initiator_id.to_s
    ar_suggestion.identity_scope = self.identity_scope.class.name
    ar_suggestion.content_scope = self.content_scope.class.name

    if self.initiator_content_scope.present?
      ar_suggestion.initiator_content_scope = self.initiator_content_scope.class.name
    end

    unless self.new_record?
      ar_suggestion.new_record = false
    end

  end

  def to_active_record_pitch_point

    ar_pitch_point = ActiveRecordPitchPoint.new

    ar_pitch_point.object_id = self.id.to_s
    ar_pitch_point.name = self.name
    ar_pitch_point.selected = self.selected
    ar_pitch_point.value = self.value

    unless self.new_record?
      ar_pitch_point.new_record = false
    end

  end

  def to_active_record_pitch_card

    ar_pitch_card = ActiveRecordPitchCard.new

    ar_pitch_card.object_id = self.id.to_s
    ar_pitch_card.status = self.status
    ar_pitch_card.initiator_id = self.initiator.id
    ar_pitch_card.identity_scope = self.identity_scope.class.name
    ar_pitch_card.content_scope = self.content_scope.class.name

    unless self.new_record?
      ar_pitch_card.new_record = false
    end

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

end