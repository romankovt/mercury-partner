# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    title { Faker::Food.dish }
    description { Faker::Food.description }

    supplier
    current_price { association :current_price, item: instance }

    after(:build) do |item, evaluator|
      if item.prices.blank? && item.current_price
        item.prices = [item.current_price]
      end
    end
  end
end
