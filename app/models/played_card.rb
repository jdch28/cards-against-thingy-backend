class PlayedCard < ApplicationRecord
  belongs_to :card
  belongs_to :game

  def self.get_session_score(session_token)
    self.where(winner: true, token: session_token).size
  end
end
