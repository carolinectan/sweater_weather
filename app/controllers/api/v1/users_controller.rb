class Api::V1::UsersController < ApplicationController
  def create
    return password_error if params[:password] != params[:password_confirmation]

    if user_params && params[:password] == params[:password_confirmation]
      new_user = User.new(user_params)
      new_user.password = params[:password]
      new_user.save!

      render json: UserSerializer.generate_api_key(new_user), status: :created
    end
  end

  def password_error
    render json: {
        message: 'Your request could not be completed.',
        errors: ['Password confirmation must match password.']
      },
      status: :bad_request
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest)
  end
end
