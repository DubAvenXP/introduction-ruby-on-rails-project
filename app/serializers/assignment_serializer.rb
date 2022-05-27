class AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :role_assignment, :amount_to_pay
  # has_one :user
  # has_one :activity
end
