require 'rails_helper'

describe "invoice API" do
  after(:each) do
    expect(response).to be_successful
  end
  describe "Endpoints" do
    it "index of all invoices" do
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      res = JSON.parse(response.body)["data"]

      expect(res.length).to eq(3)
    end

    it "shows a single invoice" do
      invoice_1 = create(:invoice)

      get "/api/v1/invoices/#{invoice_1.id}"

      res = JSON.parse(response.body)["data"]

      expect(res["id"].to_i).to eq(invoice_1.id)
    end

    describe "Finders" do
      describe "Single Finders" do
        before(:each) do
          @invoice = create(:invoice, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC")
        end

        it "primary key search" do
          get "/api/v1/invoices/find?id=#{@invoice.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["attributes"]["status"]).to eq(@invoice.status)
        end

        it "status search" do
          get "/api/v1/invoices/find?status=#{@invoice.status}"
          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@invoice.id)
        end

        it "created_at search" do
          get "/api/v1/invoices/find?created_at=#{@invoice.created_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@invoice.id)
        end

        it "updated_at search" do
          get "/api/v1/invoices/find?updated_at=#{@invoice.updated_at}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@invoice.id)
        end
      end
      describe "Multi-Finders" do
        before(:each) do
          @invoices = create_list(:invoice, 3, created_at: "2019-01-24 12:00:00 UTC", updated_at: "2019-01-24 13:00:00 UTC", status: "shipped")
        end

        it "primary key search" do
          get "/api/v1/invoices/find_all?id=#{@invoices.first.id}"

          res = JSON.parse(response.body)["data"]
          expect(res["id"].to_i).to eq(@invoices.first.id)
        end

        it "first_name search" do
          @invoices.first.status = "pending"
          @invoices.second.status = "pending"
          @invoices.first.save
          @invoices.second.save

          get "/api/v1/invoices/find_all?status=#{@invoices.first.status}"
          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@invoices.first.id)
          expect(res.second["id"].to_i).to eq(@invoices.second.id)
        end

        it "created_at search" do
          get "/api/v1/invoices/find_all?created_at=#{@invoices.first.created_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@invoices.first.id)
          expect(res.second["id"].to_i).to eq(@invoices.second.id)
          expect(res.third["id"].to_i).to eq(@invoices.third.id)
        end

        it "updated_at search" do
          get "/api/v1/invoices/find_all?updated_at=#{@invoices.first.updated_at}"

          res = JSON.parse(response.body)["data"]

          expect(res.first["id"].to_i).to eq(@invoices.first.id)
          expect(res.second["id"].to_i).to eq(@invoices.second.id)
          expect(res.third["id"].to_i).to eq(@invoices.third.id)
        end
      end
    end
  end
end
