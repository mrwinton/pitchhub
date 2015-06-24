class Comment
  include Mongoid::Document
  include Mongoid::Denormalize
  include Mongoid::Enum
  include Scopable

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :thread, inverse_of: :comments, class_name: "Thread"

  field :comment,        type: String

  # is it a root (top-level) or is it a descendant
  enum :status, [:root, :descendant]

  # == Cyclic relationship
  has_many :child, :class_name => 'Comment', :inverse_of => :parent
  belongs_to :parent, :class_name => 'Comment', :inverse_of => :child
  # has_many :child_sites, :class_name => 'Site', :inverse_of => :parent_site
  # belongs_to :parent_site, :class_name => 'Site', :inverse_of => :child_sites

  # == Validation
  validates :author, presence: true
  validates :thread, presence: true
  validates_length_of :comment, :maximum =>600, :allow_blank => false

  # == Denormalise

  denormalize :first_name, :last_name, :from => :author

end
