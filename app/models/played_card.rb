class PlayedCard < ApplicationRecord
  belongs_to :card
  belongs_to :game

  def self.get_user_score(session_token)
    self.where(winner: true, token: session_token).count
  end
end

# t.references :card
# t.references :games
# t.text :token
# t.integer :round_number
# t.boolean :winner, default: :false
