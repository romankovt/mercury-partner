# frozen_string_literal: true

class V1::ItemUpdater < V1::BaseService
  attr_reader :item, :item_params, :new_price

  def initialize(item:, params:)
    @item = item
    @new_price = params[:price]
    @item_params = params.except(:price)
  end

  def call
    ApplicationRecord.transaction do
      swap_current_price_with_new_one if new_price && item.price != new_price
      item.update!(item_params)
    end

    item
  end

  private

  def swap_current_price_with_new_one
    item.current_price.archive!
    item.prices.new(price: new_price).save!
    item.reload
  end
end
