class CreateARPitchCards < ActiveRecord::Migration
  def self.up
    create_table :ar_pitch_cards do |t|
      # t.string :title,  :null => false
      # t.boolean :done,  :null => false, :default => false
      #
      # t.timestamps
    end
  end

  def self.down
    drop_table :ar_pitch_cards
  end
end