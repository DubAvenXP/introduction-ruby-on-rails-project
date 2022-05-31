require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "has a valid description" do
    comment = build(:comment)
    expect(comment.description).to_not be_nil
    expect(comment.description).to_not be_blank
    expect(comment.description).to be_a(String)
  end

  it "has a valid user_id" do
    comment = build(:comment)
    expect(comment.user_id).to_not be_nil
    expect(comment.user_id).to be_a(Integer)
    expect(comment.user_id).to be > 0
  end

  it "has a valid activity_id" do
    comment = build(:comment)
    expect(comment.activity_id).to_not be_nil
    expect(comment.activity_id).to be_a(Integer)
    expect(comment.activity_id).to be > 0
  end
end
