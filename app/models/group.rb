class Group
  include Mongoid::Document

  embedded_in :User, inverse_of: :my_groups

  field :name,    type: String
  has_and_belongs_to_many :users,  class_name: "User"

end