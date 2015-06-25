class Discourse
  include Mongoid::Document

  belongs_to :pitch_point, class_name: "PitchPoint", inverse_of: :discourse

  has_many :comments, class_name: "Comment", inverse_of: :discourse

end