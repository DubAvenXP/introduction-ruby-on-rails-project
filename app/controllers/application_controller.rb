class ApplicationController < ActionController::API

    include JsonWebToken
    
    before_action :authenticate_request

    private

    def authenticate_request
        beared_token = request.headers['Authorization']
        token = beared_token.split(' ').last if beared_token
        
        unless token
            render json: { error: 'Not Authorized' }, status: :unauthorized
            return
        end
        
        decoded = jwt_decode(token)
        @current_user = User.find(decoded[:sub])
    end

end
