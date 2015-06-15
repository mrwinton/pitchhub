class PitchCard
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Enum

  has_mongoid_attached_file :icon_image
  validates_attachment_content_type :icon_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  enum :status, [:active, :complete]

  belongs_to :initiator, class_name: "User", inverse_of: "init_pitch_cards"
  has_and_belongs_to_many :collaborators, class_name: "User", inverse_of: "collab_pitch_cards"
  has_and_belongs_to_many :viewers, class_name: "User", inverse_of: nil

  embeds_many :pitch_points, cascade_callbacks: true

  embeds_one :initiator_scope, class_name: "DisclosureScope"
  embeds_one :pitch_card_scope, class_name: "DisclosureScope"

  accepts_nested_attributes_for :initiator, :collaborators, :pitch_points, :initiator_scope, :pitch_card_scope

end
