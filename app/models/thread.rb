class Thread
  include Mongoid::Document

  field :name,        type: String

  belongs_to :pitch_point, class_name: "PitchPoint", inverse_of: :thread

  # has_many :comments, class_name: "Comment", inverse_of: :thread

end