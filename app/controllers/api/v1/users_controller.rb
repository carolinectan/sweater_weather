require 'securerandom'

class Api::V1::UsersController < ApplicationController
  def create
    return missing_field_error if !params[:email] || !params[:password] || !params[:password_confirmation]
    return password_error if params[:password] != params[:password_confirmation]

    new_user = User.new(user_params)
    new_user.password = params[:password]
    new_user.api_key = SecureRandom.alphanumeric(27)
    new_user.update(api_key: SecureRandom.alphanumeric(27)) if new_user.api_key == User.find_by(api_key: new_user.api_key)
    new_user.save!

    render json: UserSerializer.generate_api_key(new_user), status: :created

    rescue ActiveRecord::RecordInvalid
      email_error
  end

  def password_error
    render json: {
        message: 'Your request could not be completed.',
        errors: ['Password confirmation must match password.']
      },
      status: :bad_request
  end

  def missing_field_error
    render json: {
        message: 'Your request could not be completed.',
        errors: ['All fields are required.']
      },
      status: :bad_request
  end

  def email_error
    render json: {
        message: 'Your request could not be completed.',
        errors: ['Email address has already been taken.']
      },
      status: :bad_request
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest)
  end
end
