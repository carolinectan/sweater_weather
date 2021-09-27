class Api::V1::UsersController < ApplicationController
  def create
    new_user = User.new(user_params)
    new_user.password = params[:password]
    new_user.save!

    render json: UserSerializer.generate_api_key(new_user) #status: 201
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest)
  end
end
