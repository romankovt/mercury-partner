# frozen_string_literal: true

class V1::ItemCreator < V1::BaseService
  attr_reader :item, :params, :supplier

  def initialize(supplier:, params:)
    @supplier = supplier
    @params = params
  end

  def call
    price = params[:price]
    @item = supplier.items.new(params.except(:price))

    current_price = item.build_current_price
    current_price.price = price
    item.save!

    item
  end
end
