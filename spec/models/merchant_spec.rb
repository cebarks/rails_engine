require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Validations" do
    it {should validate_presence_of :name}
  end

  describe "Class Methods" do
    it ".most_revenue" do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice, items_count: 20)

      expect(Merchant.most_revenue(2)).to eq([invoice_2.merchant, invoice_1.merchant])
    end

    it ".most_items" do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice, items_count: 20)

      expect(Merchant.most_items(2)).to eq([invoice_2.merchant, invoice_1.merchant])
    end
  end

  describe "Instance Methods" do
    it "#revenue" do
      date = "1/1/1970"
      merchant = create(:invoice, items_count: 1, created_at: date).merchant

      expect(merchant.revenue(date)).to eq(50)
    end

    it "#favorite_customer" do
      merchant = create(:merchant)
      customer = create(:customer)
      create(:invoice, merchant: merchant, items_count: 1)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant, items_count: 2)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant, items_count: 2)

      expect(merchant.favorite_customer).to eq(invoice_2.customer)
    end
  end
end
