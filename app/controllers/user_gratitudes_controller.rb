class UserGratitudesController < ApplicationController
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
    # Handle both nested and flat parameter formats
    gratitude_id = user_gratitude_params[:gratitude_id] || params[:gratitude_id]
    date = user_gratitude_params[:date] || params[:date] || Date.current
    notes = user_gratitude_params[:notes] || params[:notes]
    
    # Validate required fields
    if gratitude_id.nil?
      render json: { error: 'gratitude_id_required', message: 'Gratitude ID is required' }, status: :unprocessable_entity
      return
    end
    
    user_gratitude = UserGratitude.new(
      user_id: current_user.id,
      gratitude_id: gratitude_id,
      date: date,
      notes: notes
    )
    
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
    render json: { message: 'Gratitude deleted successfully' }, status: :ok
  end

  private

  def user_gratitude_params
    # Handle both nested and flat parameter formats
    if params[:user_gratitude].present?
      params.require(:user_gratitude).permit(:gratitude_id, :date, :notes, :user_id)
    else
      params.permit(:gratitude_id, :date, :notes, :user_id)
    end
  end
end
