class Comment
  include Mongoid::Document
  include Mongoid::Enum
  include Scopable

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :discourse, inverse_of: :comments, class_name: "Discourse"

  field :comment,        type: String

  # is it a root (top-level) or is it a descendant
  enum :message_type, [:root, :descendant]

  # == Cyclic relationship
  has_many :child, :class_name => 'Comment', :inverse_of => :parent
  belongs_to :parent, :class_name => 'Comment', :inverse_of => :child

  # == Validation
  validates :author, presence: true
  validates :discourse, presence: true
  validates_length_of :comment, :maximum => DiscoursesHelper.comment_max_length, :allow_blank => false

  # == Denormalise
  field :author_name,        type: String

  def to_jq(can_see_author)

    json = {
        :_id => _id.to_s,
        :type => "comment",
        :message_type => message_type,
        :comment => comment
    }

    if self.root?
      json[:_parent_id] = parent._id.to_s
    end

    if can_see_author
      json[:author] = author_name
    else
      json[:author] = "anonymous"
    end

    json

  end

end
