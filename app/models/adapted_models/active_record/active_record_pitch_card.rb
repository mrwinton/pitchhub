class ActiveRecordPitchCard < ActiveRecord::Base
  include MongoidAdaptable

  self.table_name = "pitch_cards"
end