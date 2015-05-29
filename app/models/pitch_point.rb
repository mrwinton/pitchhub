class PitchPoint
  include Mongoid::Document
  include Mongoid::Enum

  embedded_in :PitchCard, inverse_of: :pitch_points

  enum :status, [:selected, :unselected]

  field :name,    type: String
  field :value,   type: String

  #TODO thread or commenting

end