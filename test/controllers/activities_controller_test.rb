require "test_helper"

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity = activities(:one)
  end

  test "should get index" do
    get activities_url, as: :json
    assert_response :success
  end

  test "should create activity" do
    assert_difference("Activity.count") do
      post activities_url, params: { activity: { access_level: @activity.access_level, budget: @activity.budget, description: @activity.description, end_date: @activity.end_date, location: @activity.location, name: @activity.name, start_date: @activity.start_date, status: @activity.status, type: @activity.type } }, as: :json
    end

    assert_response :created
  end

  test "should show activity" do
    get activity_url(@activity), as: :json
    assert_response :success
  end

  test "should update activity" do
    patch activity_url(@activity), params: { activity: { access_level: @activity.access_level, budget: @activity.budget, description: @activity.description, end_date: @activity.end_date, location: @activity.location, name: @activity.name, start_date: @activity.start_date, status: @activity.status, type: @activity.type } }, as: :json
    assert_response :success
  end

  test "should destroy activity" do
    assert_difference("Activity.count", -1) do
      delete activity_url(@activity), as: :json
    end

    assert_response :no_content
  end
end
