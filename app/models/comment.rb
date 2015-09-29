class Comment
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Timestamps
  include Scopable
  include InitiatorAcceptableAndScopable

  # == Pagination, max per page
  paginates_per 200

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :pitch_card, inverse_of: :comments, class_name: "PitchCard"

  field :comment,        type: String

  # is it a root (top-level) or is it a descendant
  enum :message_type, [:root, :descendant]

  # == Cyclic relationship
  has_many :child, :class_name => 'Comment', :inverse_of => :parent, dependent: :delete
  belongs_to :parent, :class_name => 'Comment', :inverse_of => :child

  # == Denormalise
  field :author_name,        type: String
  field :pitch_point_id,     type: String
  field :pitch_point_name,   type: String
  field :initiator_id,       type: BSON::ObjectId

  # == Validation
  validates :author, presence: true
  validates :author_name, presence: true
  validates :pitch_card, presence: true
  validates :pitch_point_id, presence: true
  validates :pitch_point_name, presence: true
  validates :initiator_id, presence: true
  validates_length_of :comment, :maximum => DiscoursesHelper.comment_max_length, :allow_blank => false

end
