class PublicDisclosureScope < DisclosureScope

  # Disclosed to the public

  def is_in_scope(user)
    true
  end

end