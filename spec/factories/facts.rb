require 'faker'

FactoryBot.define do
  factory :fact do
    fact_text { Faker::ChuckNorris.fact }
    likes { Faker::Number.between(from: 0, to: 100) }
    association :member
  end
end