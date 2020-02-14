class RoundsController < ApplicationController
  before_action :load_game

  def current
  end

  def status
  end

  def card_list
  end

  def submit_card
    return if params[:token].blank? || params[:card_id].blank?

    if @current_game.played_cards.size >= Game::MAX_PLAYERS_PER_GAME - 1
      options = {
        error: 'All white cards have been submited.',
        status: 422,
      }
      render_error(options) and return
    end

    sumitted_card = @current_session.player_hand.delete(params[:card_id].to_i)
    return if sumitted_card.blank?

    @current_session.save

    card_params = {
      token: params[:token],
      card_id: sumitted_card,
      round_number: @current_game.current_round,
    }

    played_card = PlayedCard.new(card_params)

    @current_game.played_cards << played_card

    render :status
  end

  def submit_winner
    return if params[:winner_token].blank?

    winner_card = @current_game.played_cards.where(token: params[:winner_token]).take
    winner_card.winner = true
    @current_game.end_round if winner_card.save

    render :status
  end
end
