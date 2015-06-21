class PitchPoint
  include Mongoid::Document
  include ActiveModel::Validations
  validates_with PitchPointValidator

  embedded_in :PitchCard, inverse_of: :pitch_points

  field :name,        type: String

  field :selected,    type: Boolean

  field :value,        type: String

  #TODO thread or commenting
  has_many :comments

end