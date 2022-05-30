module ActivityHelpers
    extend ActiveSupport::Concern

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

    # @return [boolean]
    # @description This method is used to verify if the activity is public or not
    # return true if the activity is public
    # return false if the activity is not public (private)
    # @example
    # is_public_activity?
    def is_public_activity?
        return @activity.access_level == 'public'
    end

    def map_activity
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
                assignment_id: assignment.id,
                role_assignment: assignment.role_assignment,
                amount_to_pay: assignment.amount_to_pay,
                user: assignment.user.name,
                user_id: assignment.user.id
            }
        end
        @activity.as_json.merge({comments: comments, users: users})
    end
end