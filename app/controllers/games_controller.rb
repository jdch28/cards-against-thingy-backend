class GamesController < ApplicationController
  before_action :load_game, only: %i[join status]

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
    if @current_game.sessions.count >= Game::MAX_PLAYERS_PER_GAME
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
    @current_game
  end

  private

  def load_game
    return if params[:pin].blank?

    @current_game = Game.where(pin: params[:pin]).take

    if @current_game.blank?
      options = {
        error: "Game (PIN: #{params[:pin]}) not found.",
        status: 422,
      }
      render_error(options) and return
    end
  end
end
