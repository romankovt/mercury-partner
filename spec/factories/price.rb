# frozen_string_literal: true

FactoryBot.define do
  factory :price, aliases: [:current_price] do
    price { rand(100..10_000) }
    status { "current" }

    item
  end
end
