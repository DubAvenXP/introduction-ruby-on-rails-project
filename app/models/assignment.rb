class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  has_many :payments, dependent: :destroy

  validates :role_assignment, presence: true, inclusion: { in: %w(host member owner) }
end
