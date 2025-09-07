class Api::V1::GratitudesController < ApplicationController
  before_action :authorized

  def index
    gratitudes = Gratitude.all
    render json: gratitudes, each_serializer: GratitudeSerializer
  end

  def show
    gratitude = Gratitude.find(params[:id])
    render json: gratitude, serializer: GratitudeSerializer
  end

  def create
    gratitude = Gratitude.new(gratitude_params)
    if gratitude.save
      render json: gratitude, serializer: GratitudeSerializer, status: :created
    else
      render json: { error: 'validation_failed', message: gratitude.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    gratitude = Gratitude.find(params[:id])
    if gratitude.update(gratitude_params)
      render json: gratitude, serializer: GratitudeSerializer
    else
      render json: { error: 'validation_failed', message: gratitude.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    gratitude = Gratitude.find(params[:id])
    gratitude.destroy
    head :no_content
  end

  private

  def gratitude_params
    params.require(:gratitude).permit(:title, :category, :description)
  end
end
