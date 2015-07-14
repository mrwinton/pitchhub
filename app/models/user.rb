class User
  include Mongoid::Document
  include Mongoid::Paperclip
  include Geocoder::Model::Mongoid

  # == Include Image
  include AssociatedImage

  geocoded_by :address # can also be an IP address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? } # auto-fetch coordinates if it's not present or updated

  # Include devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :first_name, type: String
  field :last_name, type: String

  field :coordinates, :type => Array
  field :address

  has_many :groups, class_name: "Group"
  has_many :comments, class_name: "Comment"

  has_many :init_pitch_cards, class_name: "PitchCard", inverse_of: "initiator"
  has_and_belongs_to_many :collab_pitch_cards, class_name: "PitchCard", inverse_of: "collaborators"

  validates :first_name, presence: true
  validates :last_name, presence: true

end
