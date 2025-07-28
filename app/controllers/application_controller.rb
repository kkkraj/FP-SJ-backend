# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorized

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from JWT::DecodeError, with: :unauthorized
  rescue_from JWT::ExpiredSignature, with: :unauthorized

  private

  def encode_token(payload)
    JWT.encode(payload, jwt_secret, 'HS256')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(' ').last
    JWT.decode(token, jwt_secret, true, { algorithm: 'HS256' })
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  def current_user
    return unless decoded_token

    user_id = decoded_token.first['user_id']
    @current_user ||= User.find_by(id: user_id)
  end

  def logged_in?
    current_user.present?
  end

  def authorized
    render json: { error: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  def jwt_secret
    Rails.application.credentials.jwt_secret || ENV['JWT_SECRET'] || 'fallback_secret'
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def unprocessable_entity(exception)
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def unauthorized(exception = nil)
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
