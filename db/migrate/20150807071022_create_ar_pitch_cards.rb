class CreateARPitchCards < ActiveRecord::Migration
  def self.up
    create_table "ar_pitch_cards", :force => true, id: false do |t|
      t.string :object_id, primary_key: true
      t.string "status"
      t.string "initiator_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :ar_pitch_cards
  end
end