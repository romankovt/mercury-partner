# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_many :items, dependent: :restrict_with_exception
end
