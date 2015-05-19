class PitchCard
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Enum

  has_mongoid_attached_file :icon_image
  validates_attachment_content_type :icon_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  enum :status, [:active, :complete]

  has_one :initiator, class_name: "User"
  has_many :administrator, class_name: "User"

  field :title, type: String
  field :overview, type: String

  field :overview, type: String

end
