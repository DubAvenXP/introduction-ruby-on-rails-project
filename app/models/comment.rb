class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :description, presence: true, on: :create
end
