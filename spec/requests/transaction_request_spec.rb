require 'rails_helper'

describe "transaction API" do
  after(:each) do
    expect(response).to be_successful
  end
  describe "Endpoints" do
    it "index of all transactions" do
      create_list(:transaction, 3)

      get '/api/v1/transactions'

      res = JSON.parse(response.body)["data"]
      
      expect(res.length).to eq(3)
    end

    it "shows a single transaction" do
      transaction_1 = create(:transaction)

      get "/api/v1/transactions/#{transaction_1.id}"

      res = JSON.parse(response.body)["data"]

      expect(res["id"].to_i).to eq(transaction_1.id)
    end

    describe "Finders" do
      describe "Single Finders" do
        before(:each) do
          @transaction = create(:transaction, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC")
        end

        it "primary key search" do
          get "/api/v1/transactions/find?id=#{@transaction.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["attributes"]["result"]).to eq(@transaction.result)
        end

        it "result search" do
          get "/api/v1/transactions/find?result=#{@transaction.result}"
          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@transaction.id)
        end

        it "created_at search" do
          get "/api/v1/transactions/find?created_at=#{@transaction.created_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@transaction.id)
        end

        it "updated_at search" do
          get "/api/v1/transactions/find?updated_at=#{@transaction.updated_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@transaction.id)
        end
      end
      describe "Multi-Finders" do
        before(:each) do
          @transactions = create_list(:transaction, 3, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC", result: "success")
        end

        it "primary key search" do
          get "/api/v1/transactions/find_all?id=#{@transactions.first.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@transactions.first.id)
        end

        it "created_at search" do
          get "/api/v1/transactions/find_all?created_at=#{@transactions.first.created_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@transactions.first.id)
          expect(res.second["id"].to_i).to eq(@transactions.second.id)
          expect(res.third["id"].to_i).to eq(@transactions.third.id)
        end

        it "updated_at search" do
          get "/api/v1/transactions/find_all?updated_at=#{@transactions.first.updated_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@transactions.first.id)
          expect(res.second["id"].to_i).to eq(@transactions.second.id)
          expect(res.third["id"].to_i).to eq(@transactions.third.id)
        end
      end
    end
  end
end
