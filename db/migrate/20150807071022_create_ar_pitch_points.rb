class CreateARPitchPoints < ActiveRecord::Migration
  def self.up
    create_table "ar_pitch_points", :force => true, id: false do |t|
      t.string :object_id, primary_key: true
      t.foreign_key "ar_pitch_cards"
      t.string "name"
      t.boolean "selected"
      t.string "value"
    end
  end

  def self.down
    drop_table :ar_pitch_points
  end
end