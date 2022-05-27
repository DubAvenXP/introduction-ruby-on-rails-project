class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :description, presence: true
end
