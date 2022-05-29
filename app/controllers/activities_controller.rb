class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show update destroy ]

  # GET /activities
  def index
    @activities = Activity.all

    render json: @activities
  end

  # GET /activities/1
  def show
    comments = @activity.comments
    comments = comments.map do |comment|
      {
        id: comment.id,
        description: comment.description,
        user: comment.user.name
      }
    end

    assignments = @activity.assignments
    users = @activity.assignments.map do |assignment|
      {
        id: assignment.id,
        role_assignment: assignment.role_assignment,
        amount_to_pay: assignment.amount_to_pay,
        user: assignment.user.name
      }
    end

    @activity = @activity.as_json.merge({comments: comments, users: users})
    
    render json: @activity
  end

  # POST /activities
  def create

    @activity = Activity.new(activity_params)
    
    if @activity.save
      create_assignment_for_owner
      render json: @activity, status: :created, location: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1
  def update

    is_owner = is_activity_owner?

    unless is_owner
      render json: { error: 'You are not the owner of this activity' }, status: :unauthorized
      return
    end

    if @activity.update(activity_params)
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1
  def destroy
    @activity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :description, :activity_type, :location, :budget, :start_date, :end_date, :access_level, :status, :enrollment)
    end

    # @return [Assignment]
    # @description Get the owner of the activity and create an assignment for it
    # @example
    #     assignment = create_assignment_for_owner
    def create_assignment_for_owner
      @assignment = Assignment.new(user_id: @current_user.id, activity_id: @activity.id, role_assignment: 'owner', amount_to_pay: @activity.budget)
      @assignment.save
    end

    # @return [Boolean]
    # @description This method checks if the current user is the owner of the activity
    # @example
    #     is_owner = is_activity_owner?
    def is_activity_owner?
      owner = @activity.assignments.find_by(role_assignment: 'owner')
      return owner.user_id == @current_user.id
    end
end
