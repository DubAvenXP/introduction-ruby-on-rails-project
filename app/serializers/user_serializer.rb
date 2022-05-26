class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :role, :email, :status
end
