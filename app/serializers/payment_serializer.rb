class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :value, :status
  # has_one :assignment
end
