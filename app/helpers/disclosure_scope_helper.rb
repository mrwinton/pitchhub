module DisclosureScopeHelper

  def scopes(user)

    # Get the current user if signed in, else get a guest user
    curr_user = user != nil ? user : User.new
    scopes = []

    public = PublicDisclosureScope.new
    members = MemberDisclosureScope.new
    contributors = ContributorsDisclosureScope.new
    initiator = InitiatorDisclosureScope.new
    private = PrivateDisclosureScope.new

    # Add the default groups
    scopes << { :id => "public",      :scope => public,         :name => "anyone" }
    scopes << { :id => "members",     :scope => members,        :name => "members" }
    scopes << { :id => "contributors",:scope => contributors,   :name => "contributors" }
    scopes << { :id => "initiator",   :scope => initiator,      :name => "initiator and me" }
    scopes << { :id => "private",     :scope => private,        :name => "just me" }

    # Get the user's defined groups, Group or Geographic
    curr_user.groups.each do |group|
      # TODO check that id returns the ID, it may be "_id"
      group_disclosure_scope = GroupDisclosureScope.new
      group_disclosure_scope.group = group
      scopes << { :id => group.id, :scope => group_disclosure_scope,  :name => "my group: "+group.name }
    end

    scopes

  end

end
