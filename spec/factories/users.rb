require 'faker'

FactoryGirl.define do 
  factory :user do
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
  end

  factory :admin do
    admin true
  end
end