class DisclosureScope
  include Mongoid::Document
  include Mongoid::Enum

  enum :operation, [:include, :exclude]

  embedded_in :pitch_card

end
