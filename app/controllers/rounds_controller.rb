class RoundsController < ApplicationController
  before_action :load_game

  def status
  end

  def card_list
  end

  def submit_answer
    #quitar carta de la mano -> quien maneja la mano?
    render :status
  end

  def submit_winner
  end
end
