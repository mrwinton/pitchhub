class CreateARComments < ActiveRecord::Migration
  def self.up
    create_table "ar_comments", :force => true, id: false do |t|
      t.string :object_id, primary_key: true
      t.foreign_key "ar_pitch_cards"
      t.string   "author_id", :null => false
      t.string   "message_type", :null => false
      t.string   "comment", :null => false
      t.string   "author_name", :null => false
      t.string   "pitch_point_id", :null => false
      t.string   "pitch_point_name", :null => false
      t.string   "initiator_id", :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :ar_comments
  end
end