class Session < ApplicationRecord
  has_secure_token
  serialize :player_hand, Array

  belongs_to :game, optional: true
end
