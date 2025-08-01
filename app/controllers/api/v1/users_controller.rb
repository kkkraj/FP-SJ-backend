class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def index
        @users = User.all
        render json: @users
    end

    def show
        @user = User.find_by(id: params[:id])
        render json: @user
    end

    def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    def create
        user = User.create(user_params)
        if user.valid?
            token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), jwt: token }, status: :created
        else
            render json: { error: 'failed to create user', details: user.errors.full_messages }, status: :not_acceptable
        end
    end

    def update
        user = User.find_by(id: current_user.id)
        user.update(user_params)
        render json: {message: "User Account has been Updated"}
    end

    def destroy
        user = User.find_by(id: params[:id])
        user.destroy()
        render json: {message: "User Account has been Deleted!"}
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
    end
end
