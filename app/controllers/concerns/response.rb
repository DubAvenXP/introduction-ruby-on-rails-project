module Response
    extend ActiveSupport::Concern

    # @return [void]
    # @param message [Object] The message to be sent to the client
    # @param status [Integer] The status code to be sent to the client
    # @param callback [Function] The callback function to be called
    # @description This method is used to send a response to the client
    # @example
    #     basic_response(@user, :ok, @user.save)
    def basic_response(message, status, callback = true)
        if callback
            render json: message, status: status
        else
            render json: message.errors, status: :unprocessable_entity
        end
    end

    # @return [void]
    # @param message [Object] The message to be sent to the client
    # @param status [Integer] The status code to be sent to the client
    # @description This method is used to send a error response to the client
    # @example
    #     error_response(@user.errors, :unprocessable_entity)
    def error_response(message, status)
        render json: { error: message }, status: status
    end
end