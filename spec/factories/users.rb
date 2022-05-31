FactoryBot.define do
  factory :user do
    name { "John Doe" }
    role { "super_administrator" }
    password { "123456Abc$%" }
    sequence(:email) { |n| "jdoe#{n}@gmail.com" }
  end
end