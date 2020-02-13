class CreatePlayedCards < ActiveRecord::Migration[6.0]
  def change
    create_table :played_cards do |t|
      t.references :card
      t.references :games
      t.text :token
      t.integer :round_number
      t.boolean :winner, default: :false
    end
  end
end
