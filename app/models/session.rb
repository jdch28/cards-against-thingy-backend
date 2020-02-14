class Session < ApplicationRecord
  has_secure_token
  serialize :player_hand, Array

  belongs_to :game, optional: true

  def required_card_number
    Game::MAX_PLAYER_HAND - self.player_hand.size
  end

  def player_cards
    Card.select(:id, :text).where(id: player_hand)
  end
end
