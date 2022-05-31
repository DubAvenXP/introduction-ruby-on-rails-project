require 'rails_helper'

RSpec.describe Assignment, type: :model do
  it "has a valid role_assignment" do
    ['owner', 'host', 'member'].each do |role_assignment|
      assignment = build(:assignment, role_assignment: role_assignment)
      expect(assignment.role_assignment).to_not be_nil
      expect(assignment.role_assignment).to_not be_blank
      expect(assignment.role_assignment).to be_a(String)
    end
  end

  it "has a valid user_id" do
    assignment = build(:assignment)
    expect(assignment.user_id).to_not be_nil
    expect(assignment.user_id).to be_a(Integer)
    expect(assignment.user_id).to be > 0
  end

  it "has a valid activity_id" do
    assignment = build(:assignment)
    expect(assignment.activity_id).to_not be_nil
    expect(assignment.activity_id).to be_a(Integer)
    expect(assignment.activity_id).to be > 0
  end
end
