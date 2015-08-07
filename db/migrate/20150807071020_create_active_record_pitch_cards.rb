class CreateActiveRecordPitchCards < ActiveRecord::Migration
  def change
    create_table "pitch_cards", :force => true, id: false do |t|
      t.string :object_id, primary_key: true
      t.string "status"
      t.string "initiator_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end