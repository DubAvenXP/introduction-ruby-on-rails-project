require 'rails_helper'

RSpec.describe Payment, type: :model do
  it "has a valid value to realize the payment" do
    payment = build(:payment)
    expect(payment.value).to_not be_nil
    expect(payment.value).to be_a(Float)
    expect(payment.value).to be > 0
  end

  it "has a valid assignment_id" do
    payment = build(:payment)
    expect(payment.assignment_id).to_not be_nil
    expect(payment.assignment_id).to be_a(Integer)
    expect(payment.assignment_id).to be > 0
  end
end
