class UserMoodsController < ApplicationController
    def index
        @user_moods = UserMood.all
        render json: @user_moods
    end

    def create
        user_mood = UserMood.create(user_mood_params)
    end

    private
    def user_mood_params
        params.require(:user_mood).permit(:user_id, :mood_id)
    end
end
