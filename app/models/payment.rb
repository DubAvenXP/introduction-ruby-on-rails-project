class Payment < ApplicationRecord
  belongs_to :assignment

  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
  
end
