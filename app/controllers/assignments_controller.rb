class AssignmentsController < ApplicationController
  include ActivityHelpers
  include AssignmentHelpers
  include Response
  
  before_action :set_assignment, only: %i[ show update destroy ]

  def index
    @assignments = Assignment.all
    basic_response(@assignments, :ok)
  end

  def show
    basic_response(@assignment, :ok)
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @activity = Activity.find(@assignment.activity_id)

    if is_previously_assigned?
      error_response("User already assigned to activity", :bad_request)
      return
    end
    
    unless is_open_enrollment?
      error_response("The enrollments are closed", :bad_request)
      return
    end

    if !is_assignment_to_himself? and !is_activity_owner?
      error_response("You are not the owner of this activity, you can't add someone to this activity", :bad_request)
      return
    end

    if !is_public_activity? and !is_activity_owner?
      error_response("Activity is not public and need invitation from the activity owner or host", :bad_request)
      return
    end

    if @assignment.save
      update_assignments_amount_to_pay
      # TODO: notify_to_members
      assignment = Assignment.find(@assignment.id)
      basic_response(assignment, :created)
    else
      error_response(@assignment.errors, :unprocessable_entity)
    end
  end

  def update
    basic_response(@assignment, :ok, @assignment.update(assignment_params))
  end

  def destroy
    @assignment.destroy
  end

  private
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def assignment_params
      params.require(:assignment).permit(:role_assignment, :amount_to_pay, :user_id, :activity_id)
    end
end
