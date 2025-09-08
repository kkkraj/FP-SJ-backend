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
    # Handle both nested and flat parameter formats
    gratitude_id = user_gratitude_params[:gratitude_id] || params[:gratitude_id]
    gratitude_text = user_gratitude_params[:gratitude_text] || params[:gratitude_text]
    date = user_gratitude_params[:date] || params[:date] || Date.current
    notes = user_gratitude_params[:notes] || params[:notes]
    
    # Validate required fields - either gratitude_id or gratitude_text must be provided
    if gratitude_id.nil? && (gratitude_text.nil? || gratitude_text.empty?)
      render json: { error: 'gratitude_required', message: 'Either gratitude_id or gratitude_text is required' }, status: :unprocessable_entity
      return
    end
    
    # If gratitude_id is provided, check if it exists
    if gratitude_id.present?
      unless Gratitude.exists?(gratitude_id)
        render json: { error: 'gratitude_not_found', message: 'Gratitude not found' }, status: :unprocessable_entity
        return
      end
    end
    
    user_gratitude = UserGratitude.new(
      user_id: current_user.id,
      gratitude_id: gratitude_id,
      gratitude_text: gratitude_text,
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
      params.require(:user_gratitude).permit(:gratitude_id, :gratitude_text, :date, :notes, :user_id)
    else
      params.permit(:gratitude_id, :gratitude_text, :date, :notes, :user_id)
    end
  end
end
