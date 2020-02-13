class Card < ApplicationRecord
  enum card_type: {
    black: 0,
    white: 1,
  }

  scope :white_cards, -> { where(card_type: 'white') }
end
