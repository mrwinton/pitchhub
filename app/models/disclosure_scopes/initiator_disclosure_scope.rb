class InitiatorDisclosureScope < DisclosureScope

  # Disclosed to myself and the initiator

  def is_in_scope(user)
    raise NotImplementedError
  end

end