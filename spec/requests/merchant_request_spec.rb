require 'rails_helper'

describe "Merchant API" do
  describe "Endpoints" do
    it "index of all merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      res = JSON.parse(response.body)

      expect(res["data"].length).to eq(3)
    end

    it "shows a single merchant" do
      merchant_1 = create(:merchant)

      get "/api/v1/merchants/#{merchant_1.id}"

      res = JSON.parse(response.body)

      expect(res["data"]["id"].to_i).to eq(merchant_1.id)
      expect(res["data"]["attributes"]["name"]).to eq(merchant_1.name)
    end
  end
end
