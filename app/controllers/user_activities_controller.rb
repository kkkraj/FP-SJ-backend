class UserActivitiesController < ApplicationController
    def index
        user_activities = UserActivity.all
        render json: user_activities
    end

    def create
        user_activity = UserActivity.create(user_activity_params)
    end

    private
    def user_activity_params
        params.require(:user_activity).permit(:user_id, :activity_id)
    end
end
