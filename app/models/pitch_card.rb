class PitchCard
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Enum

  has_mongoid_attached_file :icon_image
  validates_attachment_content_type :icon_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  enum :status, [:active, :complete]

  belongs_to :initiator, class_name: "User"
  has_and_belongs_to_many :collaborators, class_name: "User"

  embeds_many :pitch_points, class_name: "PitchPoint"

  embeds_one :user_scope, class_name: "DisclosureScope"
  embeds_one :content_scope, class_name: "DisclosureScope"

end
