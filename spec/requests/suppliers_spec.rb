# frozen_string_literal: true

require "rails_helper"

describe "Suppliers" do
  describe "GET /suppliers" do
    let!(:suppliers) { create_list(:supplier, 2) }

    it "returns lists of suppliers" do
      get "/v1/suppliers"

      expect(response).to have_http_status(:ok)
      expect(json[:data].size).to eq 2
      expect(json[:data].pluck(:id).sort).to eq suppliers.pluck(:id).map(&:to_s).sort
    end
  end

  describe "GET /supplier/:id" do
    let(:supplier) { create(:supplier) }

    it "returns specific supplier" do
      get "/v1/suppliers/#{supplier.id}"

      expect(response).to have_http_status(:ok)
      expect(json[:data]).not_to be_empty
      expect(json[:data][:id]).to eq supplier.id.to_s
    end
  end

  describe "POST /suppliers" do
    context "with correct params" do
      let(:params) { { title: Faker::Restaurant.type, description: Faker::Restaurant.description } }

      it "returns specific supplier" do
        post "/v1/suppliers", params: params

        expect(response).to have_http_status(:created)
        expect(json[:data]).not_to be_empty
        expect(json[:data][:id]).to eq Supplier.first.id.to_s
        expect(json_attributes[:title]).to eq params[:title]
        expect(json_attributes[:description]).to eq params[:description]
      end
    end

    context "with invalid params" do
      context "when title is nil" do
        let(:params) { { title: nil, description: Faker::Restaurant.description } }

        it "returns error" do
          post "/v1/suppliers", params: params

          expect(response).to have_http_status(:bad_request)
          expect(json[:error]).not_to be_empty
        end
      end

      context "when title is not present" do
        let(:params) { { description: Faker::Restaurant.description } }

        it "returns error" do
          post "/v1/suppliers", params: params

          expect(response).to have_http_status(:bad_request)
          expect(json[:error]).not_to be_empty
        end
      end
    end
  end

  describe "PUT /suppliers/:id" do
    let(:supplier) { create(:supplier) }

    context "with correct params" do
      let(:params) { { title: Faker::Restaurant.type, description: Faker::Restaurant.description } }

      it "updates specific supplier" do
        put "/v1/suppliers/#{supplier.id}", params: params

        expect(response).to have_http_status(:ok)
        expect(json[:data]).not_to be_empty
        expect(json[:data][:id]).to eq Supplier.first.id.to_s
        expect(json_attributes[:title]).to eq params[:title]
        expect(json_attributes[:description]).to eq params[:description]
      end
    end

    context "with invalid params" do
      context "when title is nil" do
        let(:params) { { title: nil } }

        it "returns error" do
          put "/v1/suppliers/#{supplier.id}", params: params

          expect(response).to have_http_status(:bad_request)
          expect(json[:error]).not_to be_empty
        end
      end
    end
  end

  describe "DELETE /suppliers/:id" do
    let!(:supplier) { create(:supplier) }

    context "with correct params" do
      it "destroys specific supplier" do
        expect(Supplier.count).to eq 1
        delete "/v1/suppliers/#{supplier.id}"

        expect(response).to have_http_status(:ok)
        expect(Supplier.count).to eq 0
        expect(json[:data]).not_to be_empty
      end
    end
  end
end
