# frozen_string_literal: true

module Api
  module V1
    class DiaryPhotosController < ApplicationController
      before_action :set_diary_photo, only: [:show, :update, :destroy]

      def index
        @diary_photos = current_user.diary_photos
        
        if params[:date]
          @diary_photos = @diary_photos.by_date(params[:date])
        elsif params[:start_date] && params[:end_date]
          @diary_photos = @diary_photos.by_date_range(params[:start_date], params[:end_date])
        end
        
        @diary_photos = @diary_photos.recent
        
        render json: @diary_photos
      end

      def show
        render json: @diary_photo
      end

      def create
        @diary_photo = current_user.diary_photos.build(diary_photo_params)
        
        if @diary_photo.save
          render json: @diary_photo, status: :created
        else
          render json: { errors: @diary_photo.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @diary_photo.update(diary_photo_params)
          render json: @diary_photo
        else
          render json: { errors: @diary_photo.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @diary_photo.destroy
        head :no_content
      end

      private

      def set_diary_photo
        @diary_photo = current_user.diary_photos.find(params[:id])
      end

      def diary_photo_params
        # Handle both nested and direct parameter formats
        if params[:diary_photo]
          params.require(:diary_photo).permit(:photo, :diary_entry_id)
        else
          params.permit(:photo, :diary_entry_id)
        end
      end
    end
  end
end 