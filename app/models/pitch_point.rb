class PitchPoint
  include Mongoid::Document

  validates_with PitchPointValidator

  embedded_in :PitchCard, inverse_of: :pitch_points

  field :name,        type: String

  field :selected,    type: Boolean

  field :value,        type: String

  has_one :discourse, class_name: "Discourse", inverse_of: "pitch_point"

  accepts_nested_attributes_for :discourse

  # ensure that on creation a discourse is assigned
  set_callback(:create, :before) do |document|
    document.create_discourse
  end

end