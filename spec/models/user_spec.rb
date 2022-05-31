require "generic_expects"  

RSpec.describe User, type: :model,  do
  
  it "name must be valid" do
    user = FactoryBot.create(:user)
    expect_valid_string(user.name)
    expect(user.name.length).to be > 2
  end

  it "email must be valid" do
    user = FactoryBot.create(:user)
    expect(user.email).to_not be_nil
    expect(user.email).to_not be_blank
    expect(user.email).to be_a(String)
    expect(user.email).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
  end

  it "has a valid and strong password" do
    user = FactoryBot.create(:user)
    expect(user.password).to_not be_nil
    expect(user.password).to_not be_blank
    expect(user.password).to be_a(String)
    expect(user.password.length).to be > 7
    expect(user.password).to match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\z/)
  end

  it "has a valid role" do
    ["super_administrator", "team_member"].each do |role|
      user = FactoryBot.create(:user, role: role)
      expect(user.role).to_not be_nil
      expect(user.role).to be_a(String)
      expect(user.role).to eq(role)
    end
  end
end
