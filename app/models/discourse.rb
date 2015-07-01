class Discourse
  include Mongoid::Document

  has_many :comments, class_name: "Comment", inverse_of: :discourse

  field :name,        type: String

end