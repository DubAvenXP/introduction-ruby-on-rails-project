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
    # TODO: create assignment for logged user

    @activity = Activity.new(activity_params)

    if @activity.save
      render json: @activity, status: :created, location: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1
  def update
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
      params.require(:activity).permit(:name, :description, :activity_type, :location, :budget, :start_date, :end_date, :access_level, :status)
    end
end
