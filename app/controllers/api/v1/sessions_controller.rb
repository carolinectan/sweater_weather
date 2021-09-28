class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(session_params[:email])

    if !user.nil? && user.authenticate(session_params[:password])
      render json: SessionSerializer.authenticated_user(user), status: :ok
    else
      bad_credentials_error
    end
  end

  def bad_credentials_error
    render json: {
      message: 'Your request could not be completed.',
      errors: ['Bad credentials.']
    },
           status: :unauthorized
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
