class ActiveRecordPitchPoint < ActiveRecord::Base
  include MongoidAdaptable
  include ActiveRecordUpdatable

  self.table_name = "pitch_points"
end