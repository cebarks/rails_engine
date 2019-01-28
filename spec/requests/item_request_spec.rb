require 'rails_helper'

describe "item API" do
  after(:each) do
    expect(response).to be_successful
  end
  describe "Endpoints" do
    it "index of all items" do
      create_list(:item, 3)

      get '/api/v1/items'

      res = JSON.parse(response.body)["data"]

      expect(res.length).to eq(3)
    end

    it "shows a single item" do
      item_1 = create(:item)

      get "/api/v1/items/#{item_1.id}"

      res = JSON.parse(response.body)["data"]

      expect(res["id"].to_i).to eq(item_1.id)
    end

    describe "Finders" do
      describe "Single Finders" do
        before(:each) do
          @item = create(:item, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC")
        end

        it "primary key search" do
          get "/api/v1/items/find?id=#{@item.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["attributes"]["name"]).to eq(@item.name)
        end

        it "created_at search" do
          get "/api/v1/items/find?created_at=#{@item.created_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@item.id)
        end

        it "updated_at search" do
          get "/api/v1/items/find?updated_at=#{@item.updated_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@item.id)
        end
      end
      describe "Multi-Finders" do
        before(:each) do
          @items = create_list(:item, 3, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC",)
        end

        it "primary key search" do
          get "/api/v1/items/find_all?id=#{@items.first.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@items.first.id)
        end

        it "created_at search" do
          get "/api/v1/items/find_all?created_at=#{@items.first.created_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@items.first.id)
          expect(res.second["id"].to_i).to eq(@items.second.id)
          expect(res.third["id"].to_i).to eq(@items.third.id)
        end

        it "updated_at search" do
          get "/api/v1/items/find_all?updated_at=#{@items.first.updated_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@items.first.id)
          expect(res.second["id"].to_i).to eq(@items.second.id)
          expect(res.third["id"].to_i).to eq(@items.third.id)
        end
      end
    end
  end
end
