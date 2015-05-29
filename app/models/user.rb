class User
  include Mongoid::Document
  include Mongoid::Paperclip
  include Geocoder::Model::Mongoid

  geocoded_by :address # can also be an IP address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? } # auto-fetch coordinates if it's not present or updated

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :first_name, type: String
  field :last_name, type: String

  field :coordinates, :type => Array
  field :address

  has_mongoid_attached_file :avatar_image
  validates_attachment_content_type :avatar_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  has_many :my_groups, class_name: "Group"
  has_and_belongs_to_many :groups, class_name: "Group"

  has_many :init_pitch_cards, class_name: "PitchCard"
  has_and_belongs_to_many :collab_pitch_cards, class_name: "PitchCard"



end
