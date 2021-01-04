FactoryBot.define do
  factory :relationship, class: Relationship do
    followed_id { 1 }
    following_id { 1 }
  end
end
