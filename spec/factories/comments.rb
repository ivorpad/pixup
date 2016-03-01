FactoryGirl.define do
  factory :comment do
    body "MyText"
    user_id 1
    commentable nil
  end
end
