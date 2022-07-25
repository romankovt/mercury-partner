# frozen_string_literal: true

require "rails_helper"

describe "Items" do
  # default factory example
  describe "with default factory" do
    let!(:supplier) { create_default(:supplier) }

    describe "GET /items" do
      let!(:items) { create_list(:item, 2) }

      it "returns lists of items" do
        get "/v1/items", params: { supplier_id: supplier.id }
        expect(response).to have_http_status(:ok)
        expect(json[:data].size).to eq 2
        expect(json[:data].pluck(:id).sort).to eq items.pluck(:id).map(&:to_s).sort
      end
    end


    describe "GET /items/:id" do
      let(:item) { create(:item) }

      it "returns lists of items" do
        get "/v1/items/#{item.id}", params: { supplier_id: supplier.id }

        expect(response).to have_http_status(:ok)
        expect(json[:data]).not_to be_empty
        expect(json[:data][:id]).to eq item.id.to_s
      end
    end
  end

  # before hook example
  describe "PUT /items/:id" do
    context "with before_all hook" do
      before_all do
      # This will be executed only once for all suite and only then be cleaned by database cleaner
      @supplier = create(:supplier)
      @item = create(:item, supplier: @supplier)
      end

      context "with valid params" do
        let(:new_title_params) { { title: "new title" } }
        let(:new_description_params) { { description: "new description" } }

        it "updates a title" do
          put "/v1/items/#{@item.id}", params: new_title_params

          expect(response).to have_http_status(:ok)
          expect(json[:data][:id]).to eq @item.id.to_s
          expect(json_attributes[:title]).to eq new_title_params[:title]
        end

        it "updates a description" do
          put "/v1/items/#{@item.id}", params: new_description_params

          expect(response).to have_http_status(:ok)
          expect(json[:data][:id]).to eq @item.id.to_s
          expect(json_attributes[:description]).to eq new_description_params[:description]
        end
      end
    end

    # uses the same mechanism as above under the hood
    context "with let_it_be" do
      # This will be executed only once for all suite and only then be cleaned by database cleaner
      let_it_be(:supplier) { create(:supplier) }
      let_it_be(:item, refind: true) { create(:item, supplier: supplier) }

      context "when update title" do
        let(:params) { { title: "new title" } }

        it "updates a title" do
          put "/v1/items/#{item.id}", params: params

          expect(response).to have_http_status(:ok)
          expect(json[:data][:id]).to eq item.id.to_s
          expect(json_attributes[:title]).to eq params[:title]
        end
      end

      context "when update description" do
        let(:params) { { description: "new description" } }
        it "updates a description" do
          put "/v1/items/#{item.id}", params: params

          expect(response).to have_http_status(:ok)
          expect(json[:data][:id]).to eq item.id.to_s
          expect(json_attributes[:description]).to eq params[:description]
        end
      end
    end
  end
end

describe "Items with AnyFixture", :supplier do
  using TestProf::AnyFixture::DSL

  let(:supplier) { fixture(:supplier) }
  # in case test will change supplier itself we can just 're-find' it by ID
  # let(:supplier) { Supplier.find(fixture(:supplier).id) }

  describe "GET /items" do
    let!(:items) { create_list(:item, 2, supplier: supplier) }

    it "returns lists of items" do
      get "/v1/items", params: { supplier_id: supplier.id }

      expect(response).to have_http_status(:ok)
      expect(json[:data].size).to eq 2
      expect(json[:data].pluck(:id).sort).to eq items.pluck(:id).map(&:to_s).sort
    end
  end


  describe "GET /items/:id" do
    let(:item) { create(:item, supplier: supplier) }

    it "returns lists of items" do
      get "/v1/items/#{item.id}", params: { supplier_id: supplier.id }

      expect(response).to have_http_status(:ok)
      expect(json[:data]).not_to be_empty
      expect(json[:data][:id]).to eq item.id.to_s
    end
  end
end
