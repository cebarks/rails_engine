require 'rails_helper'

describe "Merchant API" do
  after(:each) do
    expect(response).to be_successful
  end
  describe "Endpoints" do
    it "index of all merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      res = JSON.parse(response.body)["data"]

      expect(res.length).to eq(3)
    end

    it "shows a single merchant" do
      merchant_1 = create(:merchant)

      get "/api/v1/merchants/#{merchant_1.id}"

      res = JSON.parse(response.body)["data"]

      expect(res["id"].to_i).to eq(merchant_1.id)
      expect(res["attributes"]["name"]).to eq(merchant_1.name)
    end

    describe "Finders" do
      describe "Single Finders" do
        before(:each) do
          @merchant = create(:merchant, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC")
        end

        it "primary key search" do
          get "/api/v1/merchants/find?id=#{@merchant.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["attributes"]["name"]).to eq(@merchant.name)
        end

        it "name search" do
          get "/api/v1/merchants/find?name=#{@merchant.name}"
          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@merchant.id)
        end

        it "created_at search" do
          get "/api/v1/merchants/find?created_at=#{@merchant.created_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@merchant.id)
        end

        it "updated_at search" do
          get "/api/v1/merchants/find?updated_at=#{@merchant.updated_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@merchant.id)
        end
      end
      describe "Multi-Finders" do
        before(:each) do
          @merchants = create_list(:merchant, 3, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC")
        end

        it "primary key search" do
          get "/api/v1/merchants/find_all?id=#{@merchants.first.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["attributes"]["name"]).to eq(@merchants.first.name)
        end

        it "name search" do
          @merchants.second.name = @merchants.first.name
          @merchants.second.save

          get "/api/v1/merchants/find_all?name=#{@merchants.first.name}"
          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@merchants.first.id)
          expect(res.second["id"].to_i).to eq(@merchants.second.id)
        end

        it "created_at search" do
          get "/api/v1/merchants/find_all?created_at=#{@merchants.first.created_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@merchants.first.id)
          expect(res.second["id"].to_i).to eq(@merchants.second.id)
          expect(res.third["id"].to_i).to eq(@merchants.third.id)
        end

        it "updated_at search" do
          get "/api/v1/merchants/find_all?updated_at=#{@merchants.first.updated_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@merchants.first.id)
          expect(res.second["id"].to_i).to eq(@merchants.second.id)
          expect(res.third["id"].to_i).to eq(@merchants.third.id)
        end
      end
    end

    describe "Business Intelligence" do
      describe "Multi" do
        it "most_revenue" do
          invoice_1 = create(:invoice)
          invoice_2 = create(:invoice, items_count: 20)

          get "/api/v1/merchants/most_revenue?quantity=1"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(invoice_2.merchant.id)
        end

        it "most_revenue quantity" do
          invoice_1 = create(:invoice)
          invoice_2 = create(:invoice, items_count: 20)

          get "/api/v1/merchants/most_revenue?quantity=2"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(invoice_2.merchant.id)
          expect(res.second["id"].to_i).to eq(invoice_1.merchant.id)
        end
      end


      describe "Single" do
        it "revenue" do
          merchant = create(:merchant)
          create(:invoice, merchant: merchant, items_count: 1)

          get "/api/v1/merchants/#{merchant.id}/revenue"

          res = JSON.parse(response.body)["data"]

          expect(res["attributes"]["revenue"]).to eq("0.5")
        end

        it "revenue by date" do
          date = "2012-03-16"

          merchant = create(:merchant)
          create(:invoice, merchant: merchant, items_count: 1, created_at: date)
          create(:invoice, merchant: merchant, items_count: 1, created_at: 1.day.ago)

          get "/api/v1/merchants/#{merchant.id}/revenue?date=#{date}"

          res = JSON.parse(response.body)["data"]
          require 'pry'; binding.pry
          expect(res["attributes"]["revenue"]).to eq("0.5")
        end

        it "favorite customer" do
          merchant = create(:merchant)
          create(:invoice, merchant: merchant, items_count: 1)
          invoice_2, invoice_2_1 = create_list(:invoice, 2, merchant: merchant, items_count: 2)

          get "/api/v1/merchants/#{merchant.id}/favorite_customer"

          res = JSON.parse(response.body)["data"]

          expect(res["id"].to_i).to eq(invoice_2.customer.id)
        end
      end
    end
  end
end
