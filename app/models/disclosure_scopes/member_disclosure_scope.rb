class MemberDisclosureScope < Scope

  # Scoped to members

  def is_in_scope(user)
    # Not going to work, user_signed_in only works when accessed from view or controller
    # user_signed_in?

    # check that the user is not a new record, if it is they are just a guest.
    not user.new_record?
  end

  def is_in_pitch_card_scope(user, pitch_card)
    is_in_scope(user)
  end

  def is_in_comment_scope(user, comment)
    is_in_scope(user)
  end

end