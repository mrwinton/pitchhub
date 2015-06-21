module Scopable
  extend ActiveSupport::Concern

  included do

    # Load Scopable Instance Methods
    include Scopable::InstanceMethods

    # == Disclosure scopes
    # initiator scope, who can see the card's initiator?
    # pitch card scope, who can see the pitch card?
    embeds_one :identity_scope, class_name: "Scope"
    embeds_one :content_scope, class_name: "Scope"

    # == Validation
    validates :identity_scope, presence: true
    validates :content_scope, presence: true

    # == Accept nested attributes
    # Important: all relations (embedded or referenced) must be permitted here
    # This allows us to use the model using this concern to have a form that also caters for the scopes
    accepts_nested_attributes_for :identity_scope, :content_scope

  end

  # == Temporary scopes
  # When creating a pitch card the form's select statements only allow value's to be ids
  # therefore we give them ids witch go into these temp fields but before_save we inject the real scopes
  # into the initiator_scope and pitch_card_scope fields
  attr_accessor :i_scope
  attr_accessor :pc_scope

  module InstanceMethods

    def inject_scopes(scopes)

      if i_scope != nil
        self.identity_scope = scope(i_scope, scopes)
      end

      if pc_scope != nil
        self.content_scope = scope(pc_scope, scopes)
      end

    end

    # == Private Methods from here down
    private

    def scope(scope_id, scopes)
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

  end

end