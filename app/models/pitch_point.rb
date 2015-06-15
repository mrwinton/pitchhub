class PitchPoint
  include Mongoid::Document
  # include Mongoid::Enum
  # include Mongoid::Attributes::Dynamic

  embedded_in :PitchCard, inverse_of: :pitch_points

  field :name,        type: String

  field :selected,    type: Boolean

  field :value,        type: String

  #TODO thread or commenting

  # @return [Object]
  def self.points
    @pitch_points = [ { :selected => true,
                        :optional => false,
                        :name => "Value Proposition",
                        :placeholder => " ",
                        :tooltip => "What's the value? *required*"
                      },
                      { :selected => true,
                        :optional => true,
                        :name => "Business Opportunity",
                        :placeholder => "challenge",
                        :tooltip => "What's the business opportunity?"
                      },
                      { :selected => true,
                        :optional => true,
                        :name => "Resources",
                        :placeholder => "enable",
                        :tooltip => "What resources will be required?"
                      },
                      { :selected => true,
                        :optional => true,
                        :name => "Solution",
                        :placeholder => "solve",
                        :tooltip => "What's the solution?"
                      },
                      { :selected => true,
                        :optional => true,
                        :name => "Facilitation",
                        :placeholder => " ",
                        :tooltip => "Looking for partners?"
                      },
                      { :selected => false,
                        :optional => true,
                        :name => "Voting",
                        :placeholder => "yes/no survey",
                        :tooltip => "Have a question to go with your pitch card?"
                      } ]
  end

  def self.point_max_length
    101
  end

end