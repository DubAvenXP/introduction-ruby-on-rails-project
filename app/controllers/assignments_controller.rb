class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[ show update destroy ]

  # GET /assignments
  def index
    @assignments = Assignment.all

    render json: @assignments
  end

  # GET /assignments/1
  def show
    render json: @assignment
  end

  # POST /assignments
  def create
    @assignment = Assignment.new(assignment_params)

    if verify_previous_assignment
      render json: { error: 'User already assigned to activity' }, status: :unprocessable_entity
      return
    end

    if @assignment.save
      render json: @assignment, status: :created, location: @assignment
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assignments/1
  def update
    if @assignment.update(assignment_params)
      render json: @assignment
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /assignments/1
  def destroy
    @assignment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assignment_params
      params.require(:assignment).permit(:role_assignment, :amount_to_pay, :user_id, :activity_id)
    end

    # @return [boolean]
    # @description This method is used to verify if the user is previously assigned to the activity
    # and return true if the user is already assigned to the activity
    # @example
    # verify_previous_assignment
    def verify_previous_assignment
      assignment = Assignment.where(user_id: @assignment.user_id, activity_id: @assignment.activity_id).first
      assignment.present?
    end
end
