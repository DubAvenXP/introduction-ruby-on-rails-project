class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  has_many :payments, dependent: :destroy

  validates :role_assignment, presence: true, inclusion: { in: %w(host member owner) }
  validates :amount_to_pay, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
end
