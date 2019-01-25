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

        xit "primary key search" do
          get "/api/v1/merchants/find_all?id=#{@merchants.first.id}"

          res = JSON.parse(response.body)["data"]
          expect(res.first["attributes"]["name"]).to eq(@merchants.first.name)
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
  end
end
