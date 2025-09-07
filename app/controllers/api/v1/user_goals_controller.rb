class Api::V1::UserGoalsController < ApplicationController
  before_action :authorized

  def index
    user_id = params[:user_id] || current_user.id
    date = params[:date] || Date.current
    
    user_goals = UserGoal.where(user_id: user_id, date: date)
    render json: user_goals, each_serializer: UserGoalSerializer
  end

  def show
    user_goal = UserGoal.find(params[:id])
    render json: user_goal, serializer: UserGoalSerializer
  end

  def create
    user_goal = UserGoal.new(user_goal_params)
    user_goal.user_id = current_user.id
    
    if user_goal.save
      render json: user_goal, serializer: UserGoalSerializer, status: :created
    else
      render json: { error: 'validation_failed', message: user_goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user_goal = UserGoal.find(params[:id])
    
    if user_goal.user_id != current_user.id
      render json: { error: 'unauthorized', message: 'You can only update your own goals' }, status: :unauthorized
      return
    end
    
    if user_goal.update(user_goal_params)
      render json: user_goal, serializer: UserGoalSerializer
    else
      render json: { error: 'validation_failed', message: user_goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user_goal = UserGoal.find(params[:id])
    
    if user_goal.user_id != current_user.id
      render json: { error: 'unauthorized', message: 'You can only delete your own goals' }, status: :unauthorized
      return
    end
    
    user_goal.destroy
    head :no_content
  end

  private

  def user_goal_params
    params.require(:user_goal).permit(:goal_id, :date, :completed, :notes)
  end
end
