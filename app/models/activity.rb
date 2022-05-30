class Activity < ApplicationRecord

    has_many :comments, dependent: :destroy
    has_many :assignments, dependent: :destroy

    validates :name, presence: true, length: { maximum: 50 }
    validates :description, presence: true,  length: { maximum: 500 }
    validates :activity_type, presence: true, inclusion: { in: %w(lunch trip party recreational_outlet) }
    validates :location, presence: true, length: { maximum: 110 }
    validates :budget, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
    #TODO: add validations for start_date and end_date
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :access_level, presence: true, inclusion: { in: %w(public private) }
    validates :enrollment, presence: false
end
