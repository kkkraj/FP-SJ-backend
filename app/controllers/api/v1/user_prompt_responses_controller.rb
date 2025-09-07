class Api::V1::UserPromptResponsesController < ApplicationController
  before_action :authorized

  def index
    user_id = params[:user_id] || current_user.id
    date = params[:date] || Date.current
    
    user_prompt_responses = UserPromptResponse.where(user_id: user_id, date: date)
    render json: user_prompt_responses, each_serializer: UserPromptResponseSerializer
  end

  def show
    user_prompt_response = UserPromptResponse.find(params[:id])
    render json: user_prompt_response, serializer: UserPromptResponseSerializer
  end

  def create
    user_prompt_response = UserPromptResponse.new(user_prompt_response_params)
    user_prompt_response.user_id = current_user.id
    
    if user_prompt_response.save
      render json: user_prompt_response, serializer: UserPromptResponseSerializer, status: :created
    else
      render json: { error: 'validation_failed', message: user_prompt_response.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user_prompt_response = UserPromptResponse.find(params[:id])
    
    if user_prompt_response.user_id != current_user.id
      render json: { error: 'unauthorized', message: 'You can only update your own responses' }, status: :unauthorized
      return
    end
    
    if user_prompt_response.update(user_prompt_response_params)
      render json: user_prompt_response, serializer: UserPromptResponseSerializer
    else
      render json: { error: 'validation_failed', message: user_prompt_response.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user_prompt_response = UserPromptResponse.find(params[:id])
    
    if user_prompt_response.user_id != current_user.id
      render json: { error: 'unauthorized', message: 'You can only delete your own responses' }, status: :unauthorized
      return
    end
    
    user_prompt_response.destroy
    head :no_content
  end

  private

  def user_prompt_response_params
    params.require(:user_prompt_response).permit(:journal_prompt_id, :date, :response)
  end
end
