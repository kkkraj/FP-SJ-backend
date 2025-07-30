class UserMoodsController < ApplicationController
    def index
        user_moods = UserMood.all
        render json: user_moods
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

    private
    def user_mood_params
        params.require(:user_mood).permit(:user_id, :mood_id)
    end
end
