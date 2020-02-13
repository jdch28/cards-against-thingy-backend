class Game < ApplicationRecord
  MAX_PLAYERS_PER_GAME = 4

  enum game_status: {
    waiting_for_players: 0,
    ready: 1,
    complete: 2,
  }

  enum round_status: {
    waiting_for_plebs: 0,
    waiting_for_czar: 1,
    complete: 2,
  }

  before_create do |game|
    game.pin = SecureRandom.hex(2).upcase
  end

  has_many :sessions, after_add: :update_status_after_join
  has_many :played_cards

  def get_winner
    win_counts = self.played_cards.where(winner: true, round_number: current_round).group(:token).count
    winner = win_counts.max_by { |k,v| v }
    session = Session.where(token: winner[0])

    {
      card: winner.card.text,
      name: session.name,
      token: session.token,
    }
  end

  def answers_for_current_round
    played_cards.where(card_type: 'white')
  end

  private

  def update_status_after_join(options = {})
    if self.sessions.count >= MAX_PLAYERS_PER_GAME
      self.status = :ready
      self.save
    end
  end
end
