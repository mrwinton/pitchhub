class MemberDisclosureScope < DisclosureScope

  # Scoped to members

  def is_in_scope(user)
    user_signed_in?
  end

end