class ContributorsDisclosureScope < DisclosureScope

  # Disclosed to myself and the collaborators + initiator

  def is_in_scope(user)
    raise NotImplementedError
  end

end