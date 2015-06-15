class InitiatorDisclosureScope < DisclosureScope

  # Disclosed to myself and the initiator

  def is_in_scope(user, content_creator)
    user.id == content_creator.id
  end

  def is_in_pitch_card_scope(user, pitch_card)
    is_in_scope(user, pitch_card.initiator)
  end

  def is_in_comment_scope(user, comment)
    if is_in_scope(user, comment.author) or is_in_scope(user, comment.pitch_point.pitch_card.initiator)
      return true
    end

    false

  end

end