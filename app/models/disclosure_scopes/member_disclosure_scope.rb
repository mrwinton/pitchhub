class MemberDisclosureScope < DisclosureScope

  # Scoped to members

  def is_in_scope(user)
    # Not going to work, user_signed_in only works when accessed from view or controller
    user_signed_in?
  end

end