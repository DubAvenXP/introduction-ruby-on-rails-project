class Activity < ApplicationRecord

    validates :name, presence: true, length: { maximum: 50 }
    validates :description, presence: true,  length: { maximum: 500 }
    validates :activity_type, presence: true, inclusion: { in: %w(lunch trip party recreational_outlet) }
    validates :location, presence: true, length: { maximum: 110 }
    validates :budget, presence: true, numericality: { only_float: true }
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :access_level, presence: true, inclusion: { in: %w(public private) }

end
