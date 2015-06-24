class PitchPoint
  include Mongoid::Document
  validates_with PitchPointValidator

  embedded_in :PitchCard, inverse_of: :pitch_points

  field :name,        type: String

  field :selected,    type: Boolean

  field :value,        type: String

  # has_one :thread, autobuild: true, inverse_of: "pitch_point"
  # has_one :thread, class_name: "Thread", inverse_of: "pitch_point"
  # , dependent: :delete, autobuild: true

end