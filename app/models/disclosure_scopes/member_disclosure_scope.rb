class MemberDisclosureScope < Scope

  # Scoped to members

  def is_in_scope(user)
    # Not going to work, user_signed_in only works when accessed from view or controller
    user_signed_in?
  end

  def is_in_pitch_card_scope(user, pitch_card)
    is_in_scope(user)
  end

  def is_in_comment_scope(user, comment)
    is_in_scope(user)
  end

end