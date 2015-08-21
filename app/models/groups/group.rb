class Group
  include Mongoid::Document
  include Mongoid::Enum

  # The user that created this group
  belongs_to :User, inverse_of: :groups

  # Group name, that will be seen by the User
  field :name,    type: String

  # The operation to be applied on this group
  # NB: 'include' is a key word, so use inc and exc, for include and exclude respectively
  enum :operation, [:inc, :exc]
#   TODO get base from which to include/exclude members


end