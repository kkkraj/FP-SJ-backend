class UserActivitiesController < ApplicationController
    def index
        user_activities = UserActivity.all
        render json: user_activities
    end

    def create
        user_activity = UserActivity.new(user_activity_params)
        user_activity.activity_date = Date.current
        
        if user_activity.save
            render json: user_activity, status: :created
        else
            render json: { error: user_activity.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private
    def user_activity_params
        params.require(:user_activity).permit(:user_id, :activity_id, :duration)
    end
end
