class ActivitiesController < ApplicationController

  include ActivityHelpers
  include AssignmentHelpers
  include Response

  before_action :set_activity, only: %i[ show update destroy ]

  def index
    @activities = Activity.all
    basic_response(@activities, :ok)
  end

  def show
    @activity = map_activity
    basic_response(@activity, :ok)
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      create_assignment_for_owner
      basic_response(@activity, :created)
    else
      error_response(@activity.errors, :unprocessable_entity)
    end
  end

  def update
    unless is_activity_owner?
      error_response('You are not the owner of this activity', :unauthorized)
      return
    end

    basic_response(@activity, :ok, @activity.update(activity_params))
  end

  def destroy
    @activity.destroy
  end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:name, :description, :activity_type, :location, :budget, :start_date, :end_date, :access_level, :status, :enrollment)
    end
end
