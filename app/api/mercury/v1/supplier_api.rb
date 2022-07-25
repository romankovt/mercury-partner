# frozen_string_literal: true

module Mercury::V1
  class SupplierAPI < Grape::API
    helpers do
      def suppliers
        @suppliers ||= Supplier.all.page(params[:page]).per(params[:per_page]).without_count
      end

      def supplier
        @supplier ||= Supplier.find(params[:id])
      end
    end

    resource :suppliers do
      desc "Returns list of suppliers" do
        summary "All the suppliers we have paginated"
        detail "Not more than 25 records per request"
        # params  API::Entities::Status.documentation
        # success API::Entities::Entity
        failure [[401, "Unauthorized", "Entities::Error"]]
        named "My named route"
        headers XAuthToken: {
                  description: "Validates your identity",
                  required: true
                },
          XOptionalHeader: {
            description: "Not really needed",
            required: false
          }
        hidden false
        deprecated false
        is_array true
        nickname "rkov"
        produces ["application/json"]
        consumes ["application/json"]
        tags ["suppliers"]
      end
      params do
        optional :page, type: Integer, values: ->(v) { v.positive? }, allow_blank: false
        optional :per_page, values: 1..25, allow_blank: false
      end
      get { V1::SupplierSerializer.new(suppliers) }

      desc "Create a supplier"
      params do
        requires :title, type: String, allow_blank: false
        # coerce empty string to a nil
        optional :description, type: String, allow_blank: true, coerce_with: ->(v) { v.presence }
      end
      post do
        supplier = Supplier.new(declared(params))
        supplier.save!
        V1::SupplierSerializer.new(supplier)
      end

      route_param :id do
        desc "Get supplier by"
        get do
          V1::SupplierSerializer.new(supplier)
        end

        desc "Update a supplier"
        params do
          optional :title, type: String, allow_blank: false
          # coerce empty string to a nil
          optional :description, type: String, allow_blank: true, coerce_with: ->(v) { v.presence }
        end
        put do
          supplier.assign_attributes(declared(params))
          supplier.save! if supplier.changed?
          V1::SupplierSerializer.new(supplier)
        end

        desc "Delete a single supplier"
        delete do
          supplier.destroy!
          V1::SupplierSerializer.new(supplier)
        end
      end
    end
  end
end
