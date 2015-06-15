class PublicDisclosureScope < DisclosureScope

  # Disclosed to the public

  def is_in_scope(user)
    # Will allow anyone to see
    true
  end

  def is_in_pitch_card_scope(user, pitch_card)
    is_in_scope(user)
  end

  def is_in_comment_scope(user, comment)
    is_in_scope(user)
  end

end