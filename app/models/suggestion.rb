class Suggestion < Comment
  include Mongoid::Enum
  include InitiatorAcceptableAndScopable

  field :content,        type: String
  validates_length_of :content, :minimum => 1, :maximum => PitchPointsHelper.pitch_point_max_length, :allow_blank => true

end
