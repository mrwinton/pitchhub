class Suggestion < Comment
  include Mongoid::Enum
  include InitiatorAcceptableAndScopable

  field :content,        type: String
  validates_length_of :content, :minimum => 1, :maximum => PitchPointsHelper.pitch_point_max_length, :allow_blank => true

  def to_jq(can_see_author)

    json = {
        :_id => _id,
        :type => "suggestion",
        :message_type => message_type,
        :content => content,
        :comment => comment
    }

    unless self.root?
      json[:_parent_id] = parent._id
    end

    if can_see_author
      json[:author] = author_name
    else
      json[:author] = "anonymous"
    end

  end

end
