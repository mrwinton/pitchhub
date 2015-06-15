class GroupDisclosureScope < DisclosureScope

  # Scoped to users in the group
  has_one :group, class_name: "Group"

  def is_in_scope(user)
    raise NotImplementedError
  end

end