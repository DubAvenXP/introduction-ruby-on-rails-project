class AuthenticationController < ApplicationController
    include Response

    skip_before_action :authenticate_request, only: [:login]

    def login
        @user = User.find_by_email(params[:email])
        
        if @user&.authenticate(params[:password])
            token = jwt_encode(sub: @user.id)
            
            user = {
                id: @user.id,
                name: @user.name,
                email: @user.email,
                role: @user.role,
            }
            
            basic_response({ user: user, token: token }, :ok)
        else
            error_response('Invalid email or password', :unauthorized)
        end
    end

    def verify_token
        if @current_user
            user = {
                id: @current_user.id,
                name: @current_user.name,
                email: @current_user.email,
                role: @current_user.role,
            }
            token = jwt_encode(sub: @current_user.id)
            basic_response({ user: user, token: token }, :ok)
        else
            error_response('Invalid token', :unauthorized)
        end
    end
end
