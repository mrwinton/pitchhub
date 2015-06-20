class GroupDisclosureScope < Scope

  # Scoped to users in the group
  has_one :group, class_name: "Group"

  def is_in_scope(user)
    group.in_group(user)
  end

  def is_in_pitch_card_scope(user, pitch_card)
    is_in_scope(user)
  end

  def is_in_comment_scope(user, comment)
    is_in_scope(user)
  end

end