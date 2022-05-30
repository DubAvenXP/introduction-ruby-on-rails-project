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
    @activity = Activity.find(@assignment.activity_id)

    if is_previously_assigned?
      render json: { error: 'User already assigned to activity' }, status: :forbidden
      return
    end

    if !is_public_activity? and !is_activity_owner?
      render json: { 
        error: "Activity is not public and the user #{@assignment.user.name} need invitation from the activity owner or host" }, 
        status: :forbidden
      return
    end

    unless is_open_enrollment?
      render json: { error: 'The enrollments are closed' }, status: :forbidden
      return
    end

    if @assignment.save
      update_users_amount_to_pay
      # TODO: notify_to_members
      assignment = Assignment.find(@assignment.id)
      render json: assignment, status: :created, location: @assignment
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
    # previously_assigned?
    def is_previously_assigned?
      assignment = Assignment.where(user_id: @assignment.user_id, activity_id: @assignment.activity_id).first
      assignment.present?
    end

    # @return [boolean]
    # @description This method is used to verify if the activity is public or not
    # return true if the activity is public
    # return false if the activity is not public (private)
    # @example
    # is_public_activity?
    def is_public_activity?
      return @activity.access_level == 'public'
    end

    # @return [Boolean]
    # @description This method checks if the current user is the owner of the activity
    # @example
    #     is_owner = is_activity_owner?
    def is_activity_owner?
      owner = @activity.assignments.find_by(role_assignment: 'owner')
      return owner.user_id == @current_user.id
    end

    # @return [Boolean]
    # @description This method return the current status of activity enrollment
    # @example
    #     is_owner = is_activity_owner?
    def is_open_enrollment?
      return @activity.enrollment
    end

    # @return [void]
    # @description This method is used to update the amount to pay of each member of the activity
    # Each time a member is assigned to an activity, the amount to pay of the member is updated
    # @example
    # update_amount_to_pay
    def update_users_amount_to_pay
      members_of_activity = @activity.assignments.where(status: true)
      amount_to_pay = @activity.budget / members_of_activity.count
      members_of_activity.each do |member|
        Assignment.update(member.id, amount_to_pay: amount_to_pay)
      end
    end
end
