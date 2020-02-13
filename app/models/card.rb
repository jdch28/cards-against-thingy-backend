class Card < ApplicationRecord
  enum card_type: {
    black: 0,
    white: 1,
  }

  scope :white_cards, -> { where(card_type: 'white') }

  def self.fetch_cards_from_deck(played_cards_ids)
    white_cards.where.not(id: played_cards_ids).sample(Game::DECK_DRAW).pluck(:id)
  end
end
