class CreateActiveRecordPitchPoints < ActiveRecord::Migration
  def change
    create_table "pitch_points", :force => true do |t|
      t.string :object_id, :null => false
      t.string   "pitch_card_id", :null => false
      t.string "name"
      t.boolean "selected"
      t.string "value"
    end
  end
end