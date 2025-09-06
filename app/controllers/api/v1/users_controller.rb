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
        # Check if name is present
        if user_params[:name].nil? || user_params[:name].empty?
            render json: { 
                error: 'name_required',
                message: 'Name is required' 
            }, status: :unprocessable_entity
            return
        end
        
        # Check if email is present
        if user_params[:email].nil? || user_params[:email].empty?
            render json: { 
                error: 'email_required',
                message: 'Email is required' 
            }, status: :unprocessable_entity
            return
        end
        
        # Check if password is present
        if user_params[:password].nil? || user_params[:password].empty?
            render json: { 
                error: 'password_required',
                message: 'Password is required' 
            }, status: :unprocessable_entity
            return
        end
        
        # Validate password confirmation before creating user
        if user_params[:password] != user_params[:password_confirmation]
            render json: { 
                error: 'passwords_dont_match',
                message: 'Password and password confirmation do not match' 
            }, status: :unprocessable_entity
            return
        end
        
        # Validate password length
        if user_params[:password].length < 6
            render json: { 
                error: 'password_too_short',
                message: 'Password must be at least 6 characters long' 
            }, status: :unprocessable_entity
            return
        end
        
        user = User.create(user_params)
        if user.valid?
            token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), jwt: token }, status: :created
        else
            # Handle specific validation errors
            if user.errors[:email].include?("has already been taken")
                render json: { 
                    error: 'user_exists',
                    message: 'A user with this email already exists' 
                }, status: :unprocessable_entity
            else
                render json: { 
                    error: 'validation_failed',
                    message: 'Failed to create user',
                    details: user.errors.full_messages 
                }, status: :unprocessable_entity
            end
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
