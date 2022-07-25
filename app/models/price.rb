# frozen_string_literal: true

class Price < ApplicationRecord
  STATUSES = [
    "current",
    "archived"
  ].freeze

  belongs_to :item

  scope :current, -> { where(status: "current") }

  validates :price, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  with_options if: :current? do
    # item should have only one current price
    validates :status, uniqueness: { scope: :item_id }
  end

  def archive!
    self.status = "archived"
    save!
  end

  def current?
    status == "current"
  end
end
