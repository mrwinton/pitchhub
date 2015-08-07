class CreateActiveRecordPitchPoints < ActiveRecord::Migration
  def change
    create_table "pitch_points", :force => true, id: false do |t|
      t.string :object_id, primary_key: true
      t.foreign_key "ar_pitch_cards"
      t.string "name"
      t.boolean "selected"
      t.string "value"
    end
  end
end