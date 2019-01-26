require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Validations" do
    it {should validate_presence_of :name}
  end

  describe "Class Methods" do
    it ".most_revenue" do
      create(:invoice)
      invoice_2 = create(:invoice, items_count: 20)

      expect(Merchant.most_revenue(1)).to eq([invoice_2.merchant])
    end
  end

  describe "Instance Methods" do
    it "#revenue" do
      merchant = create(:invoice, items_count: 1).merchant

      expect(merchant.revenue).to eq(50)
    end
  end
end
