class PitchPoint
  include Mongoid::Document

  validates_with PitchPointValidator

  embedded_in :PitchCard, inverse_of: :pitch_points

  field :name,        type: String

  field :selected,    type: Boolean

  field :value,        type: String

end