class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :status
  # has_one :user
  # has_one :activity
end
