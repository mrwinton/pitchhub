class Comment
  include Mongoid::Document
  include Mongoid::Denormalize
  include Mongoid::Enum
  include Scopable

  belongs_to :author, class_name: "User", inverse_of: :comments
  belongs_to :discourse, inverse_of: :comments, class_name: "Discourse"

  field :comment,        type: String

  # is it a root (top-level) or is it a descendant
  enum :type, [:root, :descendant]

  # == Cyclic relationship
  has_many :child, :class_name => 'Comment', :inverse_of => :parent
  belongs_to :parent, :class_name => 'Comment', :inverse_of => :child

  # == Validation
  validates :author, presence: true
  validates :discourse, presence: true
  validates_length_of :comment, :maximum => 600, :allow_blank => false

  # == Denormalise
  denormalize :first_name, :last_name, :from => :author


  def to_jq(can_see_author)

    json = {
        :_id => self._id,
        :type => type,
        :comment => comment
    }

    if self.root?
      json[:_parent_id] = self.parent._id
    end

    if can_see_author
      json[:author] = first_name + " " + last_name
    else
      json[:author] = "anonymous"
    end

  end

end
