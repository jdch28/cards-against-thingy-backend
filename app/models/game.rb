class Game < ApplicationRecord
  MAX_PLAYERS_PER_GAME = 4

  enum status: {
    waiting: 0,
    ready: 1,
    in_progress: 2,
    finished: 3,
  }

  before_create do |game|
    game.pin = SecureRandom.hex(2)
  end

  has_many :sessions, after_add: :update_status_after_join

  private

  def update_status_after_join(options = {})
    if self.sessions.count >= MAX_PLAYERS_PER_GAME
      self.status = :ready
      self.save
    end
  end
end
