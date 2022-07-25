# frozen_string_literal: true

FactoryBot.define do
  factory :supplier do
    title { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
  end
end
