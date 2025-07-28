# frozen_string_literal: true

class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by(username: params[:username]&.downcase)

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id, exp: 24.hours.from_now.to_i })
      render json: {
        user: UserSerializer.new(user).as_json,
        token: token
      }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def show
    render json: { user: UserSerializer.new(current_user).as_json }, status: :ok
  end
end
