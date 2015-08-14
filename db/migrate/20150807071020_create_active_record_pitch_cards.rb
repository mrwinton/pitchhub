class CreateActiveRecordPitchCards < ActiveRecord::Migration
  using(:master, :pitchhub_sql_shard_1, :pitchhub_sql_shard_2)

  def change
    create_table "pitch_cards", :force => true do |t|
      t.string :object_id, :null => false
      t.string "status"
      t.string "initiator_id"
      t.string "identity_scope"
      t.string "content_scope"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end