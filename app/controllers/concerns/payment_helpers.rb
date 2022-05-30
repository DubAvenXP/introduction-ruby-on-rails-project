module PaymentHelpers
    extend ActiveSupport::Concern

    # @return [Boolean]
    # @description This method verify if the payment is greater than the assignment amount
    # @example
    #     is_valid = is_valid_payment_amount?
    def is_valid_payment_amount?
        @payment.value == @payment.assignment.amount_to_pay 
    end

    # @return [Boolean]
    # @description This method verify if the current user is the owner of the assignment
    # @example
    #     is_valid = is_valid_payment?
    def is_valid_payment_user?
        @current_user.id == @payment.assignment.user_id
    end

    # @return [Boolean]
    # @description This method verify if the activity was payed
    # @example
    #     is_valid = is_valid_payment?
    def is_paid?
        payment = Payment.where(assignment_id: @payment.assignment_id).first
        payment.present?
    end
end