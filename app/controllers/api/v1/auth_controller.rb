class Api::V1::AuthController < ApplicationController
    # skip_before_action :authorized, only: [:create]

    def create
        user = User.find_by(username: params[:username])
        
        if user && user.authenticate(params[:password])
          @token = encode_token(user)
          
          render json: {id: user.id, name: user.name, email: user.email, username: user.username, jwt: @token}, status: :accepted
        else
          render json: {error: 'user could not be found'}, status: :unauthorized
        end
    end
    
    def show
        if logged_in?
          render json: { id: current_user.id, name: current_user.name, email: current_user.email, username: current_user.username }
        else
          render json: {error: 'user could not be found'}, status: 401
        end
    end

end
