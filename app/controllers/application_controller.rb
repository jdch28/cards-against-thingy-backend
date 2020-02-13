class ApplicationController < ActionController::API
  before_action :set_current_session

  private

  def set_current_session
    @current_session = Session.where(token: params[:token]).take
  end

  def render_error(options = {})
    render '/general/error', locals: { options: options }
  end

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
