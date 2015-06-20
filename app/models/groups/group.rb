class Group
  include Mongoid::Document
  include Mongoid::Enum

  # The user that created this group
  belongs_to :User, inverse_of: :groups

  # Group name, that will be seen by the User
  field :name,    type: String

  # The operation to be applied on this group
  enum :operation, [:include, :exclude]

#   TODO get base from which to include/exclude members


end