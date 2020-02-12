class Card < ApplicationRecord
  enum card_type: {
    black: 0,
    white: 1,
  }
end
