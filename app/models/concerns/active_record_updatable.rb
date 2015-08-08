module ActiveRecordUpdatable
  extend ActiveSupport::Concern

  def update_from(updated_ar_model)

    case self.class.name
      when 'ActiveRecordPitchCard'
        result = self.update_pitch_card updated_ar_model
      when 'ActiveRecordPitchPoint'
        result = self.update_pitch_point updated_ar_model
      when 'ActiveRecordComment'
        result = self.update_comment updated_ar_model
      when 'ActiveRecordSuggestion'
        result = self.update_suggestion updated_ar_model
      else
        result = nil
    end

    result
  end

  # update methods
  def update_comment(updated_comment)

    if self.comment != updated_comment.comment
      self.comment = updated_comment.comment
    end

    if self.identity_scope != updated_comment.identity_scope
      self.identity_scope = updated_comment.identity_scope
    end

    if self.content_scope != updated_comment.content_scope
      self.content_scope = updated_comment.content_scope
    end

    if updated_comment.initiator_content_scope.present?
      if self.initiator_content_scope.present?
        if self.initiator_content_scope != updated_comment.initiator_content_scope
          self.initiator_content_scope = updated_comment.initiator_content_scope
        end
      else
        self.initiator_content_scope = updated_comment.initiator_content_scope
      end
    end

  end

  def update_suggestion(updated_suggestion)

    if self.comment != updated_suggestion.comment
      self.comment = updated_suggestion.comment
    end

    if self.content != updated_suggestion.content
      self.content = updated_suggestion.content
    end

    if self.identity_scope != updated_suggestion.identity_scope
      self.identity_scope = updated_suggestion.identity_scope
    end

    if self.content_scope != updated_suggestion.content_scope
      self.content_scope = updated_suggestion.content_scope
    end

    if updated_suggestion.initiator_content_scope.present?
      if self.initiator_content_scope.present?
        if self.initiator_content_scope != updated_suggestion.initiator_content_scope
          self.initiator_content_scope = updated_suggestion.initiator_content_scope
        end
      else
        self.initiator_content_scope = updated_suggestion.initiator_content_scope
      end
    end

  end

  def update_pitch_point(updated_pitch_point)

    cur_val = self.value
    upd_val = updated_pitch_point.value

    if self.value != updated_pitch_point.value
      self.value = updated_pitch_point.value
    end

  end

  def update_pitch_card(updated_pitch_card)

    if self.identity_scope != updated_pitch_card.identity_scope
      self.identity_scope = updated_pitch_card.identity_scope
    end

    if self.content_scope != updated_pitch_card.content_scope
      self.content_scope = updated_pitch_card.content_scope
    end

  end

end