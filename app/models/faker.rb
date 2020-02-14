class Faker
  def self.set_fake_game
    game = Game.create
    sessions = [
      Session.create(name: 'Lucia'),
      Session.create(name: 'Klinsmann'),
      Session.create(name: 'Bruno'),
      Session.create(name: 'Anel')
    ]

    game.update(sessions: sessions)

    game
  end
end
