require "faker"

FactoryBot.define do
  factory :user1, class: User do
    name { "yuki" }
    email { "yuki@com" }
    password { "testtest" }
  end
  
  factory :user2, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "testtest" }
  end
  
  factory :user3, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "testtest" }
  end
  
  factory :user4, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "testtest" }
  end  
  
  factory :user5, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "testtest" }
  end
end