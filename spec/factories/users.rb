FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name 'Admin Example'
    email
    password 'helloworld'
    password_confirmation 'helloworld'
    confirmed_at Date.today
  end
end
