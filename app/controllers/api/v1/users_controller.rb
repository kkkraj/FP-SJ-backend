class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :forgot_password]

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
        # Validate password confirmation before creating user
        if user_params[:password] != user_params[:password_confirmation]
            render json: { error: 'Password and password confirmation do not match' }, status: :unprocessable_entity
            return
        end
        
        # Validate password length
        if user_params[:password].length < 6
            render json: { error: 'Password must be at least 6 characters long' }, status: :unprocessable_entity
            return
        end
        
        user = User.create(user_params)
        if user.valid?
            token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), jwt: token }, status: :created
        else
            render json: { error: 'failed to create user', details: user.errors.full_messages }, status: :not_acceptable
        end
    end

    def forgot_password
        user = User.find_by(email: params[:email])
        
        if user
            user.generate_password_reset_token
            # In a real application, you would send an email here with the reset token
            # For now, we'll just return a success message
            render json: { 
                message: 'Password reset instructions have been sent to your email address.',
                reset_token: user.reset_password_token # Only for development/testing
            }, status: :ok
        else
            render json: { 
                error: 'No user found with that email address.' 
            }, status: :not_found
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
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
