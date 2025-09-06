# frozen_string_literal: true

class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    # Handle both nested and flat parameter formats
    email = params[:email] || params.dig(:auth, :email)
    password = params[:password] || params.dig(:auth, :password)
    
    # Check if email is present
    if email.nil? || email.empty?
      render json: { 
        error: 'email_required',
        message: 'Email is required' 
      }, status: :unprocessable_entity
      return
    end
    
    # Check if password is present
    if password.nil? || password.empty?
      render json: { 
        error: 'password_required',
        message: 'Password is required' 
      }, status: :unprocessable_entity
      return
    end
    
    # Validate email format
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    unless email.match?(email_regex)
      render json: { 
        error: 'invalid_email_format',
        message: 'Please enter a valid email address' 
      }, status: :unprocessable_entity
      return
    end
    
    # Find user by email (case-insensitive)
    user = User.find_by(email: email.downcase)

    if user.nil?
      render json: { 
        error: 'user_not_found',
        message: 'User not found' 
      }, status: :not_found
    elsif user.authenticate(password)
      token = encode_token({ user_id: user.id, exp: 24.hours.from_now.to_i })
      render json: {
        user: UserSerializer.new(user).as_json,
        token: token
      }, status: :ok
    else
      render json: { 
        error: 'invalid_password',
        message: 'Invalid password' 
      }, status: :unauthorized
    end
  end

  def show
    render json: { user: UserSerializer.new(current_user).as_json }, status: :ok
  end
end
