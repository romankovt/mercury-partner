# frozen_string_literal: true

module Mercury::V1
  class Base < Grape::API
    version "v1", using: :header, vendor: "mercury-partner"
    format :json
    prefix :v1

    mount Mercury::V1::SupplierAPI
    mount Mercury::V1::ItemAPI
  end
end
