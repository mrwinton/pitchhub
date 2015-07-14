module PitchPointsHelper

  def self.pitch_points_hash
    @pitch_points = [ { :selected => true,
                        :optional => false,
                        :selected_and_emptyable => false,
                        :top_level_commentable => false,
                        :suggestible => true,
                        :name => "Value Proposition",
                        :placeholder => " ",
                        :tooltip => "Why is it important, worthwhile or useful?"
                      },
                      { :selected => true,
                        :optional => true,
                        :selected_and_emptyable => true,
                        :top_level_commentable => false,
                        :suggestible => true,
                        :name => "Business Opportunity",
                        :placeholder => "challenge",
                        :tooltip => "the challenge to tackle"
                      },
                      { :selected => true,
                        :optional => true,
                        :selected_and_emptyable => true,
                        :top_level_commentable => false,
                        :suggestible => true,
                        :name => "Resources",
                        :placeholder => "enable",
                        :tooltip => "the available resources"
                      },
                      { :selected => true,
                        :optional => true,
                        :selected_and_emptyable => true,
                        :top_level_commentable => false,
                        :suggestible => true,
                        :name => "Solution",
                        :placeholder => "solve",
                        :tooltip => "the solution"
                      },
                      { :selected => false,
                        :optional => true,
                        :selected_and_emptyable => false,
                        :top_level_commentable => true,
                        :suggestible => false,
                        :name => "Facilitation",
                        :placeholder => " ",
                        :tooltip => "Need a hand with this?"
                      },
                      { :selected => false,
                        :optional => true,
                        :selected_and_emptyable => false,
                        :top_level_commentable => false,
                        :suggestible => false,
                        :voteable => true,
                        :name => "Voting",
                        :placeholder => "yes/no survey",
                        :tooltip => "Yes/No survey"
                      } ]
  end

  # @return [Object]
  def pitch_points_hash
    PitchPointsHelper.pitch_points_hash
  end

  def self.pitch_point_max_length
    101
  end

  def pitch_point_max_length
    PitchPointsHelper.pitch_point_max_length
  end

end