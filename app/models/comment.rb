class Comment
  include Mongoid::Document
  include Scopable

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :pitch_point, class_name: "PitchPoint", inverse_of: :comments

  field :comment,        type: String

end
