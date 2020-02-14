class Game < ApplicationRecord
  MAX_PLAYERS_PER_GAME = 4
  MAX_ROUND_WINS = 3
  MAX_PLAYER_HAND = 4
  DECK_DRAW = MAX_PLAYERS_PER_GAME * MAX_PLAYER_HAND

  enum game_status: {
    waiting_for_players: 0,
    ready: 1,
    game_complete: 2,
  }

  enum round_status: {
    waiting_for_plebs: 0,
    waiting_for_czar: 1,
  }

  before_create do |game|
    game.pin = SecureRandom.hex(2).upcase
  end

  has_many :sessions, after_add: :update_game_status
  has_many :played_cards, after_add: :update_round_status

  def get_last_round_winner
    return {} if current_round == 0

    winner = self.played_cards.where(winner: true, round_number: current_round - 1).take
    winner_session = self.sessions.where(token: winner.token).take

    {
      card: winner.card.text,
      name: winner_session.name,
      token: winner_session.token,
    }
  end

  def fill_cards
    new_cards = Card.fetch_cards_from_deck(self.played_cards.pluck(:card_id))
    sessions.each do |session|
      player_cards = new_cards.pop(session.required_card_number)
      session.player_hand += player_cards
      session.save
    end
  end

  def answers_for_current_round
    self.played_cards.includes(:card).where(round_number: current_round, cards: { card_type: :white })
  end

  def get_black_card
    played_card = played_cards.includes(:card).where(cards: { card_type: :black }, round_number: current_round).take
    played_card.card.text
  end

  def next_czar_token
    sorted_token = sessions.pluck(:token).sort
    czar_index = current_round % MAX_PLAYERS_PER_GAME

    sorted_token[czar_index]
  end

  def set_round_data(skip_round_increase = false)
    update(current_round: current_round.next) unless skip_round_increase
    fill_cards

    new_black_card = Card.black_cards.sample
    PlayedCard.create(token: nil, game: self, card: new_black_card, round_number: current_round)
  end

  def end_round
    session_scores = played_cards.where(winner: true).group(:token).count
    leader = session_scores.max_by { |_token, wins| wins }

    update(game_status: :game_complete) and return if leader[1] == MAX_ROUND_WINS

    set_round_data
    update(round_status: :waiting_for_plebs)
  end

  def current_round_answer_count
    played_cards.where.not(token: nil).where(round_number: current_round).size
  end

  def current_round_winner(winner_token)
    played_cards.where(token: winner_token, round_number: current_round).take
  end

  def get_final_scores
    sessions_mapping = sessions.index_by(&:token)
    grouped_winner_cards = played_cards.where(winner: true).partition(&:token).sort_by(&:size).reverse
    grouped_winner_cards.map do |group|
      next if group.empty?

      token = group.first.token

      {
        token: token,
        name: sessions_mapping[token].name,
        score: group.size,
      }
    end.compact
  end

  private

  def update_game_status(_options = {})
    if self.sessions.size >= MAX_PLAYERS_PER_GAME
      self.game_status = :ready
      self.save
      set_round_data(true)
    end
  end

  def update_round_status(_options = {})
    if self.played_cards.where(round_number: current_round).size == MAX_PLAYERS_PER_GAME - 1
      self.round_status = :waiting_for_czar
      self.save
    end
  end
end
