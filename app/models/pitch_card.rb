class PitchCard
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Enum

  # == Status
  # is the pitch card active (taking suggestions, comments, etc) or complete (closed and no longer viewable)
  enum :status, [:active, :complete]

  # == User relations
  # the User who created the pitch card
  belongs_to :initiator, class_name: "User", inverse_of: "init_pitch_cards"
  # the Users who have suggested, commented or voted on the pitch card
  has_and_belongs_to_many :collaborators, class_name: "User", inverse_of: "collab_pitch_cards"
  # the Users who have viewed the pitch card, NB: inverse of nil, so that this is a one sided one to many relation
  has_and_belongs_to_many :viewers, class_name: "User", inverse_of: nil

  # == Pitch points
  # all the pitch points this card contains
  # cascade call_backs specified because the points are dependent
  embeds_many :pitch_points, cascade_callbacks: true

  # == Disclosure scopes
  # initiator scope, who can see the card's initiator?
  # pitch card scope, who can see the pitch card?
  embeds_one :initiator_scope, class_name: "DisclosureScope", inverse_of: "initiator_scope"
  embeds_one :pitch_card_scope, class_name: "DisclosureScope", inverse_of: "pitch_card_scope"

  # == Pitch card image
  # the face of the pitch card and it's validation
  has_mongoid_attached_file :pitch_card_image
  validates_attachment_content_type :pitch_card_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  # == Accept nested attributes
  # Important: all relations (embedded or referenced) must be permitted here
  # This allows us to use the Pitch Card form to also cater for the related models
  accepts_nested_attributes_for :initiator, :collaborators, :pitch_points, :initiator_scope, :pitch_card_scope

  # == Temporary scopes
  # When creating a pitch card the form's select statements only allow value's to be ids
  # therefore we give them ids witch go into these temp fields but before_save we inject the real scopes
  # into the initiator_scope and pitch_card_scope fields
  attr_accessor :i_scope
  attr_accessor :pc_scope

  def inject_scopes(scopes)

    if i_scope != nil
      self.initiator_scope = scope(i_scope, scopes)
    end

    if pc_scope != nil
      self.pitch_card_scope = scope(pc_scope, scopes)
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
