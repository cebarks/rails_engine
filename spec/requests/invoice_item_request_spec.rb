require 'rails_helper'

describe "invoice_item API" do
  after(:each) do
    expect(response).to be_successful
  end
  describe "Endpoints" do
    it "index of all invoice_items" do
      create_list(:invoice, 3, items_count: 1)

      get '/api/v1/invoice_items'

      res = JSON.parse(response.body)["data"]

      expect(res.length).to eq(3)
    end

    it "shows a single invoice_item" do
      invoice_item_1 = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item_1.id}"

      res = JSON.parse(response.body)["data"]

      expect(res["id"].to_i).to eq(invoice_item_1.id)
    end

    describe "Finders" do
      describe "Single Finders" do
        before(:each) do
          invoice = create(:invoice, items_count: 0)
          @invoice_item = create(:invoice_item, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC", invoice: invoice)
        end

        it "primary key search" do
          get "/api/v1/invoice_items/find?id=#{@invoice_item.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["attributes"]["id"].to_i).to eq(@invoice_item.id)
        end

        it "unit_price search" do
          get "/api/v1/invoice_items/find?unit_price=#{@invoice_item.unit_price}"

          res = JSON.parse(response.body)["data"]
          
          expect(res["id"].to_i).to eq(@invoice_item.id)
        end

        it "unit_price search" do
          get "/api/v1/invoice_items/find?created_at=#{@invoice_item.created_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@invoice_item.id)
        end

        it "updated_at search" do
          get "/api/v1/invoice_items/find?updated_at=#{@invoice_item.updated_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@invoice_item.id)
        end
      end
      describe "Multi-Finders" do
        before(:each) do
          @invoice_items = create_list(:invoice_item, 3, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC")
        end

        it "primary key search" do
          get "/api/v1/invoice_items/find_all?id=#{@invoice_items.first.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@invoice_items.first.id)
        end

        it "created_at search" do
          get "/api/v1/invoice_items/find_all?created_at=#{@invoice_items.first.created_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@invoice_items.first.id)
          expect(res.second["id"].to_i).to eq(@invoice_items.second.id)
          expect(res.third["id"].to_i).to eq(@invoice_items.third.id)
        end

        it "updated_at search" do
          get "/api/v1/invoice_items/find_all?updated_at=#{@invoice_items.first.updated_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@invoice_items.first.id)
          expect(res.second["id"].to_i).to eq(@invoice_items.second.id)
          expect(res.third["id"].to_i).to eq(@invoice_items.third.id)
        end
      end
    end
  end
end
