FactoryBot.define do
  factory :comment1, class: Comment do
    content {"This is good"}
  end
  factory :comment2, class: Comment do
    content {"This is bad"}
  end
end