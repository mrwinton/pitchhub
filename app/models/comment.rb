class Comment
  include Mongoid::Document
  include Scopable

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :thread

  field :comment,        type: String

  # == Validation
  validates :author, presence: true
  validates :pitch_point, presence: true
  validates_length_of :comment, :maximum =>600, :allow_blank => false

end
