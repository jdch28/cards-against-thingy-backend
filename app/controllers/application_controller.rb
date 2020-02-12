class ApplicationController < ActionController::API
  before_action :set_current_sesssion

  private

  def set_current_sesssion
    @current_sesssion = Session.where(token: params[:token]).take
  end
end
