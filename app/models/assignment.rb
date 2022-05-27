class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  #TODO: Add more specific validations, for example: validate if user is already assigned to activity

  validates :role_assignment, presence: true, inclusion: { in: %w(host member owner) }
  validates :amount_to_pay, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
end
