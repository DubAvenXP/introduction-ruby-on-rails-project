class AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :role_assignment, :amount_to_pay
  # belongs_to :user
  # belongs_to :activity
end
