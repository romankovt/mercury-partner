# frozen_string_literal: true

module Mercury::V1
  class ItemAPI < Grape::API
    helpers do
      def supplier
        @supplier ||= Supplier.find(params[:supplier_id])
      end

      def items
        @items ||= supplier.items.includes(:current_price).page(params[:page]).per(params[:per_page]).without_count
      end

      def item
        @item ||= Item.find(params[:id])
      end
    end

    resource :items do
      desc "Get supplier list of items"
      params do
        requires :supplier_id, type: Integer
        optional :page, type: Integer, values: ->(v) { v.positive? }, allow_blank: false
        optional :per_page, values: 1..25, allow_blank: false
      end

      get { V1::ItemSerializer.new(items) }

      desc "Create an item"
      params do
        requires :supplier_id, type: Integer
        requires :title, type: String, allow_blank: false
        # coerce empty string to a nil
        optional :description, type: String, allow_blank: true, coerce_with: ->(v) { v.presence }
        optional :price, type: Integer
      end
      post do
        item_creator = V1::ItemCreator.new(supplier: supplier, params: declared(params))
        item_creator.call
        V1::ItemSerializer.new(item_creator.item)
      end

      desc "Update an item"
      params do
        requires :supplier_id, type: Integer
        requires :title, type: String, allow_blank: false
        # coerce empty string to a nil
        optional :description, type: String, allow_blank: true, coerce_with: ->(v) { v.presence }
        optional :price, type: Integer
      end
      post do
        item_creator = V1::ItemCreator.new(supplier: supplier, params: declared(params))
        item_creator.call
        V1::ItemSerializer.new(item_creator.item)
      end

      route_param :id do
        desc "Get specific item by ID"
        get { V1::ItemSerializer.new(item) }

        desc "Update specific item by ID"
        params do
          optional :title, type: String, allow_blank: false
          # coerce empty string to a nil
          optional :description, type: String, allow_blank: true, coerce_with: ->(v) { v.presence }
          optional :price, type: Integer
        end
        put do
          item_updater = V1::ItemUpdater.new(item: item, params: declared(params, include_missing: false))
          item_updater.call
          V1::ItemSerializer.new(item_updater.item)
        end
      end
    end
  end
end
