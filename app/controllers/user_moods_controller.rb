class UserMoodsController < ApplicationController
    def index
        @user_moods = UserMood.where(user_id: params[:user_id])
        
        if params[:start_date] && params[:end_date]
            @user_moods = @user_moods.where(mood_date: params[:start_date]..params[:end_date])
        elsif params[:date]
            @user_moods = @user_moods.where("DATE(mood_date) = ?", params[:date])
        end
        
        render json: @user_moods
    end

    def create
        user_mood = UserMood.new(user_mood_params)
        user_mood.mood_date = Date.current
        
        if user_mood.save
            render json: user_mood, status: :created
        else
            render json: { error: user_mood.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @user_mood = UserMood.find_by(id: params[:id])
        if @user_mood&.destroy
            render json: { message: 'User mood deleted successfully' }
        else
            render json: { error: 'User mood not found or could not be deleted' }, status: :not_found
        end
    end

    private
    def user_mood_params
        params.require(:user_mood).permit(:user_id, :mood_id)
    end
end
