FactoryGirl.define do

  factory :user do
    username { Faker::Internet.user_name }
    password "qwerty"
  end
end
