module DisclosureScopeHelper

  def self.scopes(user, options={})
    # Options pattern
    scope_ids = ["public", "members", "contributors", "initiator", "private"]
    default_options = {
        :only => nil,
        :except => []
    }
    options = options.reverse_merge(default_options)
    options[:only] ||= scope_ids - options[:except]

    # Get the current user if signed in, else get a guest user
    curr_user = user != nil ? user : User.new

    scopes = scope_hashes(options[:only])

    # TODO allow user defined groups
    # Get the user's defined groups, Members or Geographic
    # curr_user.groups.each do |group|
    #   group_disclosure_scope = GroupDisclosureScope.new
    #   group_disclosure_scope.group = group
    #   scopes << { :id => group.id, :scope => group_disclosure_scope,  :name => "my group: "+group.name }
    # end

    scopes

  end

  def scopes(user, options={})
    DisclosureScopeHelper.scopes(user, options)
  end

  def self.scope_hashes(scopes_to_include = nil)
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

    if scopes_to_include == nil
      # return all
      scopes
    else
      scopes.select { |scope|
        scopes_to_include.include? scope[:id]
      }
    end

  end

  def scope_hashes(scopes_to_include = nil)
    DisclosureScopeHelper.scope_hashes(scopes_to_include)
  end

  def self.scope(scope_id, scopes)
    # find which scope matches
    scopes.each do |s|
      # return on match
      if s[:id] == scope_id
        return s[:scope]
      end
    end

    # could not find scope
    # TODO better exception
    raise Exception
  end

  def scope(scope_id, scopes)
    DisclosureScopeHelper.scope(scope_id, scopes)
  end

end
