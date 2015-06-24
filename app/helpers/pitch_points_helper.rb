module PitchPointsHelper

  def self.pitch_points_hash
    @pitch_points = [ { :selected => true,
                        :optional => false,
                        :selected_and_emptyable => false,
                        :top_level_comments => false,
                        :name => "Value Proposition",
                        :placeholder => " ",
                        :tooltip => "What's the value? *required*"
                      },
                      { :selected => true,
                        :optional => true,
                        :selected_and_emptyable => true,
                        :top_level_comments => false,
                        :name => "Business Opportunity",
                        :placeholder => "challenge",
                        :tooltip => "What's the business opportunity?"
                      },
                      { :selected => true,
                        :optional => true,
                        :selected_and_emptyable => true,
                        :top_level_comments => false,
                        :name => "Resources",
                        :placeholder => "enable",
                        :tooltip => "What resources will be required?"
                      },
                      { :selected => true,
                        :optional => true,
                        :selected_and_emptyable => true,
                        :top_level_comments => false,
                        :name => "Solution",
                        :placeholder => "solve",
                        :tooltip => "What's the solution?"
                      },
                      { :selected => true,
                        :optional => true,
                        :selected_and_emptyable => true,
                        :top_level_comments => true,
                        :name => "Facilitation",
                        :placeholder => " ",
                        :tooltip => "Looking for partners?"
                      },
                      { :selected => false,
                        :optional => true,
                        :selected_and_emptyable => false,
                        :top_level_comments => false,
                        :name => "Voting",
                        :placeholder => "yes/no survey",
                        :tooltip => "Have a question to go with your pitch card?"
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