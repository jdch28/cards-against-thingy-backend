class Game < ApplicationRecord
  MAX_PLAYERS_PER_GAME = 4
  MAX_ROUND_WINS = 3

  enum game_status: {
    waiting_for_players: 0,
    ready: 1,
    game_complete: 2,
  }

  enum round_status: {
    waiting_for_plebs: 0,
    waiting_for_czar: 1,
    round_complete: 2,
  }

  before_create do |game|
    game.pin = SecureRandom.hex(2).upcase
  end

  has_many :sessions, after_add: :update_game_status
  has_many :played_cards, after_add: :update_round_status

  def get_current_round_winner
    winner = self.played_cards.where(winner: true, round_number: current_round).take
    winner_session = self.sessions.where(token: winner.token).take
    win_count = self.played_cards.where(winner: true, token: winner.token).take

    self.game_status = :game_complete if win_count == MAX_ROUND_WINS
    self.round_status = :round_complete

    {
      card: winner.card.text,
      name: winner_session.name,
      token: winner_session.token,
    }
  end

  def answers_for_current_round
    self.played_cards.includes(:card).where(round_number: current_round, cards: { card_type: 'white' })
  end

  private

  def update_game_status(_options = {})
    if self.sessions.size >= MAX_PLAYERS_PER_GAME
      self.game_status = :ready
      self.save
    end
  end

  def update_round_status(_options = {})
    if self.played_cards.where(round_number: current_round).size == MAX_PLAYERS_PER_GAME - 1
      self.round_status = :waiting_for_czar
      self.save
    end
  end
end
