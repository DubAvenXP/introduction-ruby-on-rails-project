FactoryBot.define do
  factory :assignment do
    role_assignment { "member" }
    user_id { 2 }
    activity_id { 4 }
  end
end
