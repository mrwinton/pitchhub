module InitiatorAcceptableAndScopable
  extend ActiveSupport::Concern

  included do

    # Load InitiatorAcceptableAndScopable Instance Methods
    include InitiatorAcceptableAndScopable::InstanceMethods

    enum :status, [:pending, :accepted, :rejected]

    # == Disclosure scopes
    # when the initiator accepts or rejects we override the content scope, who can see the pitch card?
    embeds_one :initiator_content_scope, class_name: "Scope"


    # == Accept nested attributes
    # Important: all relations (embedded or referenced) must be permitted here
    # This allows us to use the model using this concern to have a form that also caters for the scopes
    accepts_nested_attributes_for :initiator_content_scope

    # == Scopes
    # scopes to make the query syntax s readable and concise
    scope :initiator_content_scoped_for, ->(user){
      where('$or' => [
                { "initiator_id" => user.id },
                { 'initiator_content_scope' => { "$exists" => false }, "author_id" => user.id },
                { 'initiator_content_scope' => { "$exists" => true }, 'initiator_content_scope._type' => "PublicDisclosureScope"},
                { 'initiator_content_scope' => { "$exists" => true }, 'initiator_content_scope._type' => "PrivateDisclosureScope", "initiator_id" => user.id },
                { 'initiator_content_scope' => { "$exists" => true }, 'initiator_content_scope._type' => "MemberDisclosureScope"},
                { 'initiator_content_scope' => { "$exists" => true }, 'initiator_content_scope._type' => "InitiatorDisclosureScope", "initiator_id" => user.id },
                { 'initiator_content_scope' => { "$exists" => true }, 'initiator_content_scope._type' => "InitiatorDisclosureScope", "author_id" => user.id },
                { 'initiator_content_scope' => { "$exists" => true }, 'initiator_content_scope._type' => "ContributorsDisclosureScope", "collaborator_ids" => { "$in" => [ user.id ]}}
            ])
    }

  end

  # == Temporary scopes
  # When creating a pitch card the form's select statements only allow value's to be ids
  # therefore we give them ids witch go into these temp fields but before_save we inject the real scopes
  # into the intiator_content_scope field
  attr_accessor :ic_scope

  module InstanceMethods

    def inject_scopes(scopes)

      if ic_scope != nil
        self.initiator_content_scope = DisclosureScopeHelper.scope(ic_scope, scopes)
      end

      # inject any other scopes from inherited methods (if any)
      super

    end

  end

end