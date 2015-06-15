class Comment
  include Mongoid::Document

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :pitch_point, class_name: "PitchPoint", inverse_of: :comments

  field :comment,        type: String

  embeds_one :author_scope, class_name: "DisclosureScope", inverse_of: "author_scope"
  embeds_one :content_scope, class_name: "DisclosureScope", inverse_of: "content_scope"

end
