class SessionsController < ApplicationController
  def create
    @session = Session.new(session_params)

    if @session.save
      render json: @session, status: :created
    else
      render_error error: @session.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def session_params
    params.require(:session).permit(:name)
  end
end
