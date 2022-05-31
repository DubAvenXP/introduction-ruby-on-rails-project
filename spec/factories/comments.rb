FactoryBot.define do
  factory :comment do
    description { "This is a comment" }
    user_id { 1 }
    activity_id { 1 }
  end
end
