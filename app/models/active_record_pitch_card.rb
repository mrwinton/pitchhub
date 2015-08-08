class ActiveRecordPitchCard < ActiveRecord::Base
  include MongoidAdaptable
  include ActiveRecordUpdatable

  self.table_name = "pitch_cards"
end