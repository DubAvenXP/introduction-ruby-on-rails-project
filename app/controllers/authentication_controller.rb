class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [:login]

    #POST /auth/login
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

            render json: { user: user, token: token }, status: :ok
        else
            render json: { error: 'Invalid email or password!!' }, status: :unauthorized
        end
    end
end
