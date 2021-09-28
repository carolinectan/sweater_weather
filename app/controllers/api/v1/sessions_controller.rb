class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(session_params[:email])

    if user.authenticate(session_params[:password])
      UserSerializer.authenticated_user
    end

    # if user.password_digest == session_params[:password]
    #   give_token
    # end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
