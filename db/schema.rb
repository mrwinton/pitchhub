ActiveRecord::Schema.define(:version => 20150807071022) do

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

  create_table "ar_suggestions", :force => true, id: false do |t|
    t.string :object_id, primary_key: true
    t.foreign_key "ar_pitch_cards"
    t.string   "author_id", :null => false
    t.string   "message_type", :null => false
    t.string   "comment", :null => false
    t.string   "content", :null => false
    t.string   "author_name", :null => false
    t.string   "pitch_point_id", :null => false
    t.string   "pitch_point_name", :null => false
    t.string   "initiator_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ar_pitch_cards", :force => true, id: false do |t|
    t.string :object_id, primary_key: true
    t.string "status"
    t.string "initiator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ar_pitch_points", :force => true, id: false do |t|
    t.string :object_id, primary_key: true
    t.foreign_key "ar_pitch_cards"
    t.string "name"
    t.boolean "selected"
    t.string "value"
  end

end