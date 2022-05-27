class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :activity_type, :location, :budget, :start_date, :end_date, :access_level, :status
  # has_many :comments, serializer: CommentSerializer
end
