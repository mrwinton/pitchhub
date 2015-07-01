class PitchCard
  include Mongoid::Document
  include Mongoid::EmbeddedErrors
  include Mongoid::Paperclip
  include Mongoid::Timestamps
  include Mongoid::Enum
  # == Include Scope Of Disclosure abilities to PitchCard
  include Scopable
  # == Include Image
  include AssociatedImage

  # == Pagination, max per page
  paginates_per 10

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

  # == Message relations
  # the comments and suggestions associated with this card
  has_many :comments, class_name: "Comment", inverse_of: "pitch_card"

  # == Pitch points
  # all the pitch points this card contains
  # cascade call_backs specified because the points are dependent
  embeds_many :pitch_points, cascade_callbacks: true

  # == Validation
  validates :initiator, presence: true
  validates_associated :pitch_points

  # == Accept nested attributes
  # Important: all relations (embedded or referenced) must be permitted here
  # This allows us to use the Pitch Card form to also cater for the related models
  accepts_nested_attributes_for :initiator, :collaborators, :pitch_points

end
