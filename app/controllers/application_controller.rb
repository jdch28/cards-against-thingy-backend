class ApplicationController < ActionController::API
  before_action :set_current_session

  private

  def set_current_session
    @current_session = Session.where(token: params[:token]).take
  end

  def render_error(options = {})
    render '/general/error', locals: { options: options }
  end
end
