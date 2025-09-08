class UserGoalsController < ApplicationController
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
    # Handle both nested and flat parameter formats
    goal_text = user_goal_params[:goal_text] || params[:goal_text]
    date = user_goal_params[:date] || params[:date] || Date.current
    completed = user_goal_params[:completed] || params[:completed] || false
    notes = user_goal_params[:notes] || params[:notes]
    
    # Validate required fields
    if goal_text.nil? || goal_text.empty?
      render json: { error: 'goal_text_required', message: 'Goal text is required' }, status: :unprocessable_entity
      return
    end
    
    user_goal = UserGoal.new(
      user_id: current_user.id,
      goal_text: goal_text,
      date: date,
      completed: completed,
      notes: notes
    )
    
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
    render json: { message: 'Goal deleted successfully' }, status: :ok
  end

  private

  def user_goal_params
    # Handle both nested and flat parameter formats
    if params[:user_goal].present?
      params.require(:user_goal).permit(:goal_id, :goal_text, :date, :completed, :notes, :user_id)
    else
      params.permit(:goal_id, :goal_text, :date, :completed, :notes, :user_id)
    end
  end
end
