class Api::V1::UserGratitudesController < ApplicationController
  before_action :authorized

  def index
    user_id = params[:user_id] || current_user.id
    date = params[:date] || Date.current
    
    user_gratitudes = UserGratitude.where(user_id: user_id, date: date)
    render json: user_gratitudes, each_serializer: UserGratitudeSerializer
  end

  def show
    user_gratitude = UserGratitude.find(params[:id])
    render json: user_gratitude, serializer: UserGratitudeSerializer
  end

  def create
    user_gratitude = UserGratitude.new(user_gratitude_params)
    user_gratitude.user_id = current_user.id
    
    if user_gratitude.save
      render json: user_gratitude, serializer: UserGratitudeSerializer, status: :created
    else
      render json: { error: 'validation_failed', message: user_gratitude.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user_gratitude = UserGratitude.find(params[:id])
    
    if user_gratitude.user_id != current_user.id
      render json: { error: 'unauthorized', message: 'You can only update your own gratitudes' }, status: :unauthorized
      return
    end
    
    if user_gratitude.update(user_gratitude_params)
      render json: user_gratitude, serializer: UserGratitudeSerializer
    else
      render json: { error: 'validation_failed', message: user_gratitude.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user_gratitude = UserGratitude.find(params[:id])
    
    if user_gratitude.user_id != current_user.id
      render json: { error: 'unauthorized', message: 'You can only delete your own gratitudes' }, status: :unauthorized
      return
    end
    
    user_gratitude.destroy
    head :no_content
  end

  private

  def user_gratitude_params
    params.require(:user_gratitude).permit(:gratitude_id, :date, :notes)
  end
end
