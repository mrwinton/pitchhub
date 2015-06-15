class PrivateDisclosureScope < DisclosureScope

  # Disclosed to myself

  def is_in_scope(user)
    raise NotImplementedError
  end

end