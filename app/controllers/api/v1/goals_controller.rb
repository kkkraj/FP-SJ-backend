class Api::V1::GoalsController < ApplicationController
  before_action :authorized

  def index
    goals = Goal.all
    render json: goals, each_serializer: GoalSerializer
  end

  def show
    goal = Goal.find(params[:id])
    render json: goal, serializer: GoalSerializer
  end

  def create
    goal = Goal.new(goal_params)
    if goal.save
      render json: goal, serializer: GoalSerializer, status: :created
    else
      render json: { error: 'validation_failed', message: goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    goal = Goal.find(params[:id])
    if goal.update(goal_params)
      render json: goal, serializer: GoalSerializer
    else
      render json: { error: 'validation_failed', message: goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    head :no_content
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :category, :description)
  end
end
