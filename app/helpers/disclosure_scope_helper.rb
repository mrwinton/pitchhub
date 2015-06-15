module DisclosureScopeHelper

  def scopes

    # Get the current user if signed in, else get a guest user
    curr_user = user_signed_in? ? current_user : User.new

    scopes = []

    # Add the default groups
    scopes << { :scope => "public",        :name => "anyone" }
    scopes << { :scope => "members",       :name => "members of PitchHub" }
    scopes << { :scope => "contributors",  :name => "contributors on this card" }
    scopes << { :scope => "initiator",     :name => "initiator and me" }
    scopes << { :scope => "private",       :name => "just me" }

    # Get the user's defined groups, Group or Geographic
    curr_user.groups.each do |group|
      # TODO check that id returns the ID, it may be "_id"
      scopes << { :scope => group.id, :name => "my group: "+group.name }
    end

    scopes

  end

end
