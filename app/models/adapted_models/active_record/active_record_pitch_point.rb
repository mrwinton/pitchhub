class ActiveRecordPitchPoint < ActiveRecord::Base
  include MongoidAdaptable

  self.table_name = "pitch_points"
end