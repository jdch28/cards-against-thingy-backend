class CreatePlayedCards < ActiveRecord::Migration[6.0]
  def change
    create_table :played_cards do |t|
      t.references :card
      t.references :game
      t.text :token
      t.integer :round_number, default: 0
      t.boolean :winner, default: :false
    end
  end
end
