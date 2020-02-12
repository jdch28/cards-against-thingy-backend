class ApplicationController < ActionController::API
  before_action :set_current_session

  private

  def set_current_session
    @current_session = Session.where(token: params[:token]).take
  end
end
