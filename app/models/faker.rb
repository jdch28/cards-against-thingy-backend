class Faker
  def self.set_fake_game
    game = Game.create
    sessions = [
      Session.create(name: 'Anel'),
      Session.create(name: 'Bruno'),
      Session.create(name: 'Klinsmann'),
      Session.create(name: 'Lucia'),
    ]

    game.update(sessions: sessions)

    game
  end

  def self.fake_results
    game = set_fake_game
    cards = Card.pluck(:id)
    sessions = game.sessions.pluck(:token)

    (1..4).each do |score|
      score.times do |i|
        card_params = {
          token: sessions[score - 1],
          card_id: cards.sample,
          round_number: score + i,
          winner: true,
        }

        played_card = PlayedCard.new(card_params)
        game.played_cards << played_card
      end
    end
    game
  end
end
