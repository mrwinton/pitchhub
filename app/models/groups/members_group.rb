class MembersGroup < Group

  # The members the user has specified to be in this group
  has_and_belongs_to_many :group_members, class_name: "User", inverse_of: nil

  def in_group(user_to_check)
    raise NotImplementedError
  end


end