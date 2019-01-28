require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_numericality_of :unit_price}
  end

  describe "Relationships" do
    it {should belong_to :merchant}
  end

  describe "Class Methods" do
    it ".most_items" do
      item_1, item_2, * = create_list(:item, 3)
      invoice_1 = create(:invoice, items_count: 0)
      invoice_2 = create(:invoice, items_count: 0)
      create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 20)
      create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 15)

      expect(Item.most_items(2)).to eq([item_1, item_2])
    end
  end
end
