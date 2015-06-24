module InitiatorAcceptableAndScopable
  extend ActiveSupport::Concern

  included do

    # Load InitiatorAcceptableAndScopable Instance Methods
    include InitiatorAcceptableAndScopable::InstanceMethods

    enum :status, [:accepted, :rejected]

    # == Disclosure scopes
    # when the initiator accepts or rejects we override the content scope, who can see the pitch card?
    embeds_one :initiator_content_scope, class_name: "Scope"


    # == Accept nested attributes
    # Important: all relations (embedded or referenced) must be permitted here
    # This allows us to use the model using this concern to have a form that also caters for the scopes
    accepts_nested_attributes_for :initiator_content_scope

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