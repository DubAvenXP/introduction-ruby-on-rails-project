module AssignmentHelpers
    extend ActiveSupport::Concern

    # @return [Assignment]
    # @description Get the owner of the activity and create an assignment for it
    # @example
    #     assignment = create_assignment_for_owner
    def create_assignment_for_owner
        @assignment = Assignment.new(user_id: @current_user.id, activity_id: @activity.id, role_assignment: 'owner', amount_to_pay: @activity.budget)
        @assignment.save
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

    def is_assignment_to_himself?
        @assignment.user_id == @current_user.id
    end

    # @return [void]
    # @description This method is used to update the amount to pay of each member of the activity
    # Each time a member is assigned to an activity, the amount to pay of the member is updated
    # @example
    # update_amount_to_pay
    def update_assignments_amount_to_pay
        members_of_activity = @activity.assignments.where(status: true)
        amount_to_pay = @activity.budget / members_of_activity.count
        members_of_activity.each do |member|
            Assignment.update(member.id, amount_to_pay: amount_to_pay)
        end
    end
end