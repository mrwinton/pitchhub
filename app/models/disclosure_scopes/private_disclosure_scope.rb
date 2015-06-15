class PrivateDisclosureScope < DisclosureScope

  # Disclosed to myself

  def is_in_scope(user, content_creator)
    user.id == content_creator.id
  end

  def is_in_pitch_card_scope(user, pitch_card)
    is_in_scope(user, pitch_card.initiator)
  end

  def is_in_comment_scope(user, comment)
    is_in_scope(user, comment.author)
  end

end