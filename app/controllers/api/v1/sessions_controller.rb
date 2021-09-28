class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(session_params[:email])

    if user.authenticate(session_params[:password])
      render json: SessionSerializer.authenticated_user(user)
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end