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
        # Handle both nested and flat parameter formats
        name = user_params[:name] || params[:name]
        email = user_params[:email] || params[:email]
        password = user_params[:password] || params[:password]
        password_confirmation = user_params[:password_confirmation] || params[:password_confirmation]
        
        # Check if name is present
        if name.nil? || name.empty?
            render json: { 
                error: 'name_required',
                message: 'Name is required' 
            }, status: :unprocessable_entity
            return
        end
        
        # Validate name length
        if name.length < 2
            render json: { 
                error: 'name_too_short',
                message: 'Name must be at least 2 characters long' 
            }, status: :unprocessable_entity
            return
        end
        
        if name.length > 50
            render json: { 
                error: 'name_too_long',
                message: 'Name must be less than 50 characters' 
            }, status: :unprocessable_entity
            return
        end
        
        # Check if email is present
        if email.nil? || email.empty?
            render json: { 
                error: 'email_required',
                message: 'Email is required' 
            }, status: :unprocessable_entity
            return
        end
        
        # Validate email format
        email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
        unless email.match?(email_regex)
            render json: { 
                error: 'invalid_email_format',
                message: 'Please enter a valid email address' 
            }, status: :unprocessable_entity
            return
        end
        
        # Check if password is present
        if password.nil? || password.empty?
            render json: { 
                error: 'password_required',
                message: 'Password is required' 
            }, status: :unprocessable_entity
            return
        end
        
        # Validate password confirmation before creating user
        if password != password_confirmation
            render json: { 
                error: 'passwords_dont_match',
                message: 'Password and password confirmation do not match' 
            }, status: :unprocessable_entity
            return
        end
        
        # Validate password length
        if password.length < 6
            render json: { 
                error: 'password_too_short',
                message: 'Password must be at least 6 characters long' 
            }, status: :unprocessable_entity
            return
        end
        
        if password.length > 128
            render json: { 
                error: 'password_too_long',
                message: 'Password must be less than 128 characters' 
            }, status: :unprocessable_entity
            return
        end
        
        # Create user with the extracted parameters
        user = User.create(
            name: name,
            email: email,
            password: password,
            password_confirmation: password_confirmation
        )
        
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
        # Handle both nested and flat parameter formats
        name = user_params[:name] || params[:name]
        email = user_params[:email] || params[:email]

        # Check if at least one field is provided
        if (name.nil? || name.empty?) && (email.nil? || email.empty?)
            render json: {
                error: 'no_fields_provided',
                message: 'At least one field (name or email) must be provided'
            }, status: :unprocessable_entity
            return
        end

        # Validate name if provided
        if name.present?
            # Check if name is not empty
            if name.empty?
                render json: {
                    error: 'name_required',
                    message: 'Name cannot be empty'
                }, status: :unprocessable_entity
                return
            end

            # Validate name length
            if name.length < 2
                render json: {
                    error: 'name_too_short',
                    message: 'Name must be at least 2 characters long'
                }, status: :unprocessable_entity
                return
            end

            if name.length > 50
                render json: {
                    error: 'name_too_long',
                    message: 'Name must be less than 50 characters'
                }, status: :unprocessable_entity
                return
            end

            # Check if name is different from current name
            if name.strip.downcase == current_user.name.strip.downcase
                render json: {
                    error: 'name_unchanged',
                    message: 'New name must be different from current name'
                }, status: :unprocessable_entity
                return
            end
        end

        # Check if email is present (only if provided)
        if email.present? && email.empty?
            render json: {
                error: 'email_required',
                message: 'Email cannot be empty'
            }, status: :unprocessable_entity
            return
        end

        # Validate email format (only if email is provided)
        if email.present?
            email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
            unless email.match?(email_regex)
                render json: {
                    error: 'invalid_email_format',
                    message: 'Please enter a valid email address'
                }, status: :unprocessable_entity
                return
            end

            # Check if email is different from current email
            if email.strip.downcase == current_user.email.strip.downcase
                render json: {
                    error: 'email_unchanged',
                    message: 'New email must be different from current email'
                }, status: :unprocessable_entity
                return
            end

            # Check if email is already taken by another user
            existing_user = User.find_by(email: email.downcase)
            if existing_user && existing_user.id != current_user.id
                render json: {
                    error: 'email_taken',
                    message: 'This email is already taken by another user'
                }, status: :unprocessable_entity
                return
            end
        end

        begin
            # Prepare update attributes - only include fields that were provided
            update_attributes = {}
            update_attributes[:name] = name if name.present?
            update_attributes[:email] = email.downcase if email.present?

            # Update the user
            current_user.update!(update_attributes)

            # Generate photo URL if user has a profile photo
            photo_url = nil
            if current_user.profile_photo.attached?
                photo_url = Rails.application.routes.url_helpers.rails_blob_url(
                    current_user.profile_photo, 
                    host: Rails.application.config.action_controller.default_url_options[:host], 
                    port: Rails.application.config.action_controller.default_url_options[:port]
                )
            end

            # Return success message with updated user data for real-time UI updates
            render status: :ok, json: {
                message: "User account updated successfully",
                user: {
                    id: current_user.id,
                    name: current_user.name,
                    email: current_user.email,
                    photo: photo_url,
                    created_at: current_user.created_at,
                    updated_at: current_user.updated_at
                }
            }
        rescue => e
            render json: {
                error: 'update_failed',
                message: 'Failed to update user account',
                details: e.message
            }, status: :internal_server_error
        end
    end

    def destroy
        user = User.find_by(id: params[:id])
        user.destroy()
        render json: {message: "User Account has been Deleted!"}
    end

    def upload_photo
        # Check if photo is present
        unless params[:photo].present?
            render json: {
                error: 'photo_required',
                message: 'Photo is required'
            }, status: :unprocessable_entity
            return
        end

        # Validate file type
        allowed_types = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
        unless allowed_types.include?(params[:photo].content_type)
            render json: {
                error: 'invalid_file_type',
                message: 'Only JPEG, PNG, and GIF images are allowed'
            }, status: :unprocessable_entity
            return
        end

        # Validate file size (max 5MB)
        max_size = 5.megabytes
        if params[:photo].size > max_size
            render json: {
                error: 'file_too_large',
                message: 'File size must be less than 5MB'
            }, status: :unprocessable_entity
            return
        end

        begin
            # Attach the photo to the current user
            current_user.profile_photo.attach(params[:photo])
            
            # Generate the photo URL
            photo_url = Rails.application.routes.url_helpers.rails_blob_url(current_user.profile_photo, host: Rails.application.config.action_controller.default_url_options[:host], port: Rails.application.config.action_controller.default_url_options[:port])
            
            render json: {
                photo_url: photo_url,
                message: 'Photo uploaded successfully'
            }, status: :ok
        rescue => e
            render json: {
                error: 'upload_failed',
                message: 'Failed to upload photo',
                details: e.message
            }, status: :internal_server_error
        end
    end

    def delete_photo
        # Check if user has a profile photo
        unless current_user.profile_photo.attached?
            render json: {
                error: 'no_photo',
                message: 'No profile photo to delete'
            }, status: :not_found
            return
        end

        begin
            # Delete the profile photo
            current_user.profile_photo.purge
            
            render json: {
                message: 'Profile picture deleted successfully',
                photo_url: nil
            }, status: :ok
        rescue => e
            render json: {
                error: 'delete_failed',
                message: 'Failed to delete profile photo',
                details: e.message
            }, status: :internal_server_error
        end
    end

    def update_password
        # Handle both nested and flat parameter formats
        current_password = params[:current_password] || params.dig(:password, :current_password)
        new_password = params[:new_password] || params.dig(:password, :new_password)
        password_confirmation = params[:password_confirmation] || params.dig(:password, :password_confirmation)

        # Check if current password is present
        if current_password.nil? || current_password.empty?
            render json: {
                error: 'current_password_required',
                message: 'Current password is required'
            }, status: :unprocessable_entity
            return
        end

        # Check if new password is present
        if new_password.nil? || new_password.empty?
            render json: {
                error: 'new_password_required',
                message: 'New password is required'
            }, status: :unprocessable_entity
            return
        end

        # Check if password confirmation is present
        if password_confirmation.nil? || password_confirmation.empty?
            render json: {
                error: 'password_confirmation_required',
                message: 'Password confirmation is required'
            }, status: :unprocessable_entity
            return
        end

        # Validate current password
        unless current_user.authenticate(current_password)
            render json: {
                error: 'invalid_current_password',
                message: 'Current password is incorrect'
            }, status: :unauthorized
            return
        end

        # Validate new password length
        if new_password.length < 6
            render json: {
                error: 'new_password_too_short',
                message: 'New password must be at least 6 characters long'
            }, status: :unprocessable_entity
            return
        end

        if new_password.length > 128
            render json: {
                error: 'new_password_too_long',
                message: 'New password must be less than 128 characters'
            }, status: :unprocessable_entity
            return
        end

        # Validate password confirmation
        if new_password != password_confirmation
            render json: {
                error: 'passwords_dont_match',
                message: 'New password and password confirmation do not match'
            }, status: :unprocessable_entity
            return
        end

        # Check if new password is different from current password
        if current_user.authenticate(new_password)
            render json: {
                error: 'same_password',
                message: 'New password must be different from current password'
            }, status: :unprocessable_entity
            return
        end

        begin
            # Update the password
            current_user.update!(password: new_password, password_confirmation: password_confirmation)
            
            render json: {
                message: 'Password updated successfully'
            }, status: :ok
        rescue => e
            render json: {
                error: 'password_update_failed',
                message: 'Failed to update password',
                details: e.message
            }, status: :internal_server_error
        end
    end

    private
    def user_params
        params.fetch(:user, {}).permit(:name, :email)
    end
end
