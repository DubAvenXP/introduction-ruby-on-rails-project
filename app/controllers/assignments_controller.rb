class AssignmentsController < ApplicationController
  include ActivityHelpers
  include AssignmentHelpers
  include Response
  
  before_action :set_assignment, only: %i[ show update destroy ]
  before_action :set_activity_id, only: %i[ create index destroy update]

  def index
    @assignments = Assignment.where(activity_id: @activity_id)
    basic_response(@assignments, :ok)
  end

  def show
    basic_response(@assignment, :ok)
  end

  def create
    merged_params = assignment_params.merge(activity_id: @activity_id)
    @assignment = Assignment.new(merged_params)
    @activity = Activity.find(@activity_id)

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
    @activity = Activity.find(@activity_id)

    if !is_assignment_to_himself? and !is_activity_owner?
      error_response("You are not the owner of this activity, you can't modify someone to this activity", :bad_request)
      return
    end

    basic_response(@assignment, :ok, @assignment.update(assignment_params))
  end

  def destroy
    @activity = Activity.find(@activity_id)

    if !is_assignment_to_himself? and !is_activity_owner?
      error_response("You are not the owner of this activity, you can't delete someone to this activity", :bad_request)
      return
    end

    @assignment.destroy
    update_assignments_amount_to_pay
  end

  private
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def set_activity_id
      @activity_id = params[:activity_id]
    end

    def assignment_params
      params.require(:assignment).permit(:role_assignment, :user_id, :activity_id)
    end
end
