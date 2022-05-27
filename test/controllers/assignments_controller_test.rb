require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assignment = assignments(:one)
  end

  test "should get index" do
    get assignments_url, as: :json
    assert_response :success
  end

  test "should create assignment" do
    assert_difference("Assignment.count") do
      post assignments_url, params: { assignment: { activity_id: @assignment.activity_id, amount_to_pay: @assignment.amount_to_pay, role_assignment: @assignment.role_assignment, user_id: @assignment.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show assignment" do
    get assignment_url(@assignment), as: :json
    assert_response :success
  end

  test "should update assignment" do
    patch assignment_url(@assignment), params: { assignment: { activity_id: @assignment.activity_id, amount_to_pay: @assignment.amount_to_pay, role_assignment: @assignment.role_assignment, user_id: @assignment.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy assignment" do
    assert_difference("Assignment.count", -1) do
      delete assignment_url(@assignment), as: :json
    end

    assert_response :no_content
  end
end
