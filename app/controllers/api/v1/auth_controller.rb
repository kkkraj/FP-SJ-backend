class Api::V1::AuthController < ApplicationController
    # skip_before_action :authorized, only: [:create]

    # def create #POST login 
    #     @user = User.find_by(username: user_login_params[:username])
    #     if @user && @user.authenticate(user_login_params[:password])
    #         @token = encode_token({ user_id: @user.id })
    #         render json: { user: UserSerializer.new(@user), jwt: @token }, status: :accepted
    #     else
    #         render json: { message: 'Invalid username or password' }, status: :unauthorized
    #     end
    # end

    # private
    # def user_login_params
    #     params.require(:user).permit(:username, :password)
    # end
    ###########################################################################################
    def create
        user = User.find_by(username: params[:username])
        
        if user && user.authenticate(params[:password])
          my_token = issue_token(user)
          
          render json: {id: user.id, username: user.username, token: my_token}
        else
          render json: {error: 'That user could not be found'}, status: 401
        end
      end
    
    
      
      def show
        if logged_in?
          render json: { id: current_user.id, username: current_user.username }
        else
          render json: {error: 'No user could be found'}, status: 401
        end
      end
end
