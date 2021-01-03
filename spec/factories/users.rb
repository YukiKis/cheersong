FactoryBot.define do
  factory :user1, class: User do
    name { "yuki" }
    email { "yuki@com" }
    password { "testtest" }
  end
end