require 'faker'

FactoryGirl.define do
  factory :contact do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    sequence(:email) { Faker::Internet.email }
  end
end