require 'faker'

FactoryGirl.define do
  factory :news_release do
    title "Test news release"
    released_on 1.day.ago
    body { Faker::Lorem.paragraph }

    factory :news_cfo do
      title "Record profits for BigCo!"
      released_on "2013-08-01"
      body { "Today, BigCo's CFO announced record growth." }
    end
  end
end