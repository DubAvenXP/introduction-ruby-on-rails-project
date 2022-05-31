require 'rails_helper'

RSpec.describe Activity, type: :model do

  it "has a valid name" do 
    activity = build(:activity)
    expect(activity.name).to_not be_nil
    expect(activity.name).to_not be_blank
    expect(activity.name).to be_a(String)
  end

  it "has a valid description" do 
    activity = build(:activity)
    expect(activity.description).to_not be_nil
    expect(activity.description).to_not be_blank
    expect(activity.description).to be_a(String)
  end

  it "has a valid activity_type" do 
    ["lunch", "trip", "party", "recreational_outlet"].each do |type|
      activity = build(:activity, activity_type: type)
      expect(activity.activity_type).to_not be_nil
      expect(activity.activity_type).to_not be_blank
      expect(activity.activity_type).to be_a(String)
      expect(activity.activity_type).to eq(type)
    end
  end

  it "has a valid location" do 
    activity = build(:activity)
    expect(activity.location).to_not be_nil
    expect(activity.location).to_not be_blank
    expect(activity.location).to be_a(String)
  end

  it "has a valid budget" do 
    activity = build(:activity)
    expect(activity.budget).to_not be_nil
    expect(activity.budget).to be_a(Float)
    expect(activity.budget).to be > 0
  end

  it "has a valid start_date" do 
    activity = build(:activity)
    expect(activity.start_date).to_not be_nil
    expect(activity.start_date).to_not be_blank
    expect(activity.start_date).to be > Date.today
    expect(activity.start_date).to be < activity.end_date
  end

  it "has a valid end_date" do 
    activity = build(:activity)
    expect(activity.end_date).to_not be_nil
    expect(activity.end_date).to_not be_blank
    expect(activity.end_date).to be > activity.start_date
  end

  it "has a valid access_level" do 
    ['public', 'private'].each do |access_level|
      activity = build(:activity, access_level: access_level)
      expect(activity.access_level).to_not be_nil
      expect(activity.access_level).to_not be_blank
      expect(activity.access_level).to be_a(String)
      expect(activity.access_level).to eq(access_level)
    end
  end

end

