class Comment
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Timestamps
  # == Include Scope Of Disclosure abilities to PitchCard
  include Scopable
  include InitiatorAcceptableAndScopable
  # == Include secret sharing
  include SecretSharingModel

  # == Pagination, max per page
  paginates_per 20

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :pitch_card, inverse_of: :comments, class_name: "PitchCard"

  field :comment,        type: String

  # is it a root (top-level) or is it a descendant
  enum :message_type, [:root, :descendant]

  # == Cyclic relationship
  has_many :child, :class_name => 'Comment', :inverse_of => :parent
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

  def self.split(discourse, n)

    # contains the shares
    discourse_array = []

    # share values
    shares_values = SecretSharingHelper.split_secret(discourse.comment)

    # for n times, add the discourse share to array
    (0..n).each do |counter|

      # duplicate the original discourse
      discourse_share = discourse.dup

      discourse_share.comment = shares_values[counter]

      # IMPORTANT: ensure they all have the same ids
      discourse_share.id = id

      # add the share to the array
      discourse_array << discourse_share

    end

    # now completed, return the array of discourses with secure comments
    discourse_array

  end

  def self.combine(discourse_shares)

    # get a share to serve as the base discourse that we will inject the secret_values with
    discourse = discourse_shares.delete_at(0)

    discourse_secret_shares = []

    discourse_shares.each do |discourse_share|

      discourse_secret_shares << discourse_share.comment

    end

    # combine the shares
    secret_value = SecretSharingHelper.combine_secret_shares(discourse_secret_shares)

    discourse.comment = secret_value

    discourse

  end


end
