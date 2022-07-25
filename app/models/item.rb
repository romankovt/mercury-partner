# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :supplier

  has_one :current_price, -> { merge(Price.current) }, class_name: "Price", dependent: nil,
    inverse_of: :item
  has_many :prices, dependent: :destroy

  validates :title, presence: true
  validates :current_price, presence: true

  accepts_nested_attributes_for :current_price

  delegate :price, to: :current_price
end
