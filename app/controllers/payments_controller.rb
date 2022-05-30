class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show update destroy ]

  # GET /payments
  def index
    @payments = Payment.all

    render json: @payments
  end

  # GET /payments/1
  def show
    render json: @payment
  end

  # POST /payments
  def create
    @payment = Payment.new(payment_params)
    @activity = Assignment.find(params[:assignment_id]).activity
    
    if is_open_enrollment?
      render json: { error: "You can't pay if the enrollment is open" }, status: :unprocessable_entity
      return
    end

    unless is_valid_payment?
      render json: { error: "The payment is not valid" }, status: :unprocessable_entity
      return
    end

    if @payment.save
      render json: @payment, status: :created, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payments/1
  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:value, :status, :assignment_id)
    end

    # @return [Boolean]
    # @description This method return the current status of activity enrollment
    # @example
    #     is_open = is_open_enrollment?
    def is_open_enrollment?
      return @activity.enrollment
    end

    # @return [Boolean]
    # @description This method verify if the payment is greater than the assignment amount
    # @example
    #     is_valid = is_valid_payment?
    def is_valid_payment?
      return @payment.value == @payment.assignment.amount_to_pay 
    end
end
