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
  # == Include secret sharing
  include SecretSharingCoordination

  # == Pagination, max per page
  paginates_per 20

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

  # == Instance methods

  # Return the pitch card's value proposition point
  def value_proposition

    pitch_points.each do |point|
      if point.name == "Value Proposition"
        return point.value
      end
    end

    # return blank string if we could not find the value proposition point
    ""
  end

  def self.split(pitch_card, n)

    # contains the shares
    pitch_card_array = []

    # pitch_point_hash_array = { :facilitation => [0, 1, 2, ... , n] }
    pitch_point_hash_of_arrays = {}

    # construct the hash of arrays containing pitch point shares
    pitch_card.pitch_points.each do |point|

      pitch_point_hash_of_arrays[point.name] = []

        # if it' a value proposition we don't want to encrypt
        if point.name == "Value Proposition"

          n.times{

            pitch_point_hash_of_arrays[point.name] << point.value

          }

        else

          # the secret shares array for this pitch_point
          shares = pitch_card.split_secret(secret)

          pitch_point_hash_of_arrays[point.name] = shares


        end
    end

    # for n times, add the pitch card share to array
    (0..n).each do |counter|

      # duplicate the original pitch card
      pitch_card_share = pitch_card.dup

      # using the pitch point has update the points
      pitch_point_hash_of_arrays.each do |point_name, array_of_point_value_shares|

        # get the value at the counter
        share_value = array_of_point_value_shares[counter]

        # update
        pitch_card.pitch_points_attributes = [
            { name: point_name, value: share_value }
        ]

      end

      # add the share to the array
      pitch_card_array << pitch_card_share

    end

    # now completed, return the array of pitch cards with secure pitch points
    pitch_card_array

  end

  def self.combine(pitch_card_shares)

    # get a share to serve as the base pitch_card that we will inject the secret_values with
    pitch_card = pitch_card_shares.delete_at(0)

    # for each pitch point that is active
    # reject pitch points that are not selected
    pitch_card.pitch_points.each do |point|

      point_shares = []

      # add this
      point_shares << point.value

      # for each share
      pitch_card_shares.each do |pitch_card_share|

        # for each pitch point in each share
        pitch_card_share.pitch_points.each do |share_point|

          # if the point name's are equal, add the value to the point shares
          if point[:name] == share_point[:name]

            point_shares << share_point.value

          end

        end

      end

      # combine the shares
      secret_value = pitch_card.combine_secret_shares(point_shares)

      # set share in base pitch_card
      pitch_card.pitch_points_attributes = [
          { name: point.name, value: secret_value }
      ]

    end

    # return the pitch card with the secret value set
    pitch_card

  end

end
