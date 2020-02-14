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
end
