class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :pin
      t.integer :game_status, default: 0
      t.integer :round_status, default: 0
      t.integer :current_round, default: 0
      t.timestamps
    end
  end
end
