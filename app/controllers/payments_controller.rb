class PaymentsController < ApplicationController
  include PaymentHelpers
  include ActivityHelpers
  include Response

  before_action :set_payment, only: %i[ show update destroy ]

  def index
    @payments = Payment.all
    basic_response(@payments, :ok)
  end

  def show
    basic_response(@payment, :ok)
  end

  def create
    @payment = Payment.new(payment_params)
    @activity = Assignment.find(params[:assignment_id]).activity
    
    if is_open_enrollment?
      error_response("You can't pay if the enrollment is open", :bad_request)
      return
    end

    if is_paid?
      error_response("You can't pay twice", :bad_request)
      return
    end

    unless is_valid_payment_amount?
      error_response("The payment amount is not valid", :bad_request)
      return
    end

    unless is_valid_payment_user?
      error_response("You can't pay for this assignment", :bad_request)
      return
    end

    basic_response(@payment, :created, @payment.save)
  end

  def update
    basic_response(@payment, :ok, @payment.update(payment_params))
  end

  def destroy
    @payment.destroy
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:value, :status, :assignment_id)
    end
end
