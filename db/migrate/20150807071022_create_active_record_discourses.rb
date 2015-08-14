class CreateActiveRecordDiscourses < ActiveRecord::Migration
  using(:master, :pitchhub_sql_shard_1, :pitchhub_sql_shard_2)

  def change
    create_table "discourses", :force => true do |t|
      t.string :object_id, :null => false
      t.string   "pitch_card_id", :null => false
      t.string   "author_id", :null => false
      t.string   "discourse_type", :null => false
      t.string   "message_type", :null => false
      t.string   "comment", :null => false
      t.string   "content", :null => true #it may be null, when it's a suggestion
      t.string   "author_name", :null => false
      t.string   "pitch_point_id", :null => false
      t.string   "pitch_point_name", :null => false
      t.string   "initiator_id", :null => false
      t.string "identity_scope", :null => false
      t.string "content_scope", :null => false
      t.string "initiator_content_scope", :null => true #it may be null, when first initialised
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end