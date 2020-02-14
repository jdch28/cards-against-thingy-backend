class GamesController < ApplicationController
  before_action :load_game, only: %i[join status]

  def fake
    @game = Faker.set_fake_game
  end

  def create
    if @current_session.blank?
      options = {
        error: 'Current session not found.',
        status: 404,
      }
      render_error(options) and return
    end

    @current_game = Game.create
    @current_game.sessions << @current_session
  end

  def join
    if @current_game.sessions.size >= Game::MAX_PLAYERS_PER_GAME
      options = {
        error: 'Game lobby is already full.',
        status: 422,
      }
      render_error(options) and return
    end

    @current_game.sessions << @current_session
    render :status
  end

  def status
  end
end
