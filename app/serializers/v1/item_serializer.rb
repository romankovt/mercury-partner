# frozen_string_literal: true

class V1::ItemSerializer < V1::BaseSerializer
  attributes :title, :description

  attribute :price do |object|
    object.current_price.price
  end
end
