require 'rails_helper'

describe "customer API" do
  after(:each) do
    expect(response).to be_successful
  end
  describe "Endpoints" do
    it "index of all customers" do
      create_list(:customer, 3)

      get '/api/v1/customers'

      res = JSON.parse(response.body)["data"]

      expect(res.length).to eq(3)
    end

    it "shows a single customer" do
      customer_1 = create(:customer)

      get "/api/v1/customers/#{customer_1.id}"

      res = JSON.parse(response.body)["data"]

      expect(res["id"].to_i).to eq(customer_1.id)
      expect(res["attributes"]["first_name"]).to eq(customer_1.first_name)
      expect(res["attributes"]["last_name"]).to eq(customer_1.last_name)
    end

    describe "Finders" do
      describe "Single Finders" do
        before(:each) do
          @customer = create(:customer, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC")
        end

        it "primary key search" do
          get "/api/v1/customers/find?id=#{@customer.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["attributes"]["first_name"]).to eq(@customer.first_name)
          expect(res["attributes"]["last_name"]).to eq(@customer.last_name)
        end

        it "first_name search" do
          get "/api/v1/customers/find?first_name=#{@customer.first_name}"
          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@customer.id)
        end

        it "last_name search" do
          get "/api/v1/customers/find?last_name=#{@customer.last_name}"
          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@customer.id)
        end

        it "created_at search" do
          get "/api/v1/customers/find?created_at=#{@customer.created_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@customer.id)
        end

        it "updated_at search" do
          get "/api/v1/customers/find?updated_at=#{@customer.updated_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@customer.id)
        end
      end
      describe "Multi-Finders" do
        before(:each) do
          @customers = create_list(:customer, 3, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC")
        end

        xit "primary key search" do
          get "/api/v1/customers/find_all?id=#{@customers.first.id}"

          res = JSON.parse(response.body)["data"]
          expect(res.first["attributes"]["name"]).to eq(@customers.first.name)
        end

        it "first_name search" do
          @customers.second.first_name = @customers.first.first_name
          @customers.second.save

          get "/api/v1/customers/find_all?first_name=#{@customers.first.first_name}"
          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@customers.first.id)
          expect(res.second["id"].to_i).to eq(@customers.second.id)
        end

        it "last_name search" do
          @customers.second.last_name = @customers.first.last_name
          @customers.second.save

          get "/api/v1/customers/find_all?last_name=#{@customers.first.last_name}"
          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@customers.first.id)
          expect(res.second["id"].to_i).to eq(@customers.second.id)
        end

        it "created_at search" do
          get "/api/v1/customers/find_all?created_at=#{@customers.first.created_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@customers.first.id)
          expect(res.second["id"].to_i).to eq(@customers.second.id)
          expect(res.third["id"].to_i).to eq(@customers.third.id)
        end

        it "updated_at search" do
          get "/api/v1/customers/find_all?updated_at=#{@customers.first.updated_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@customers.first.id)
          expect(res.second["id"].to_i).to eq(@customers.second.id)
          expect(res.third["id"].to_i).to eq(@customers.third.id)
        end
      end
    end
  end
end
