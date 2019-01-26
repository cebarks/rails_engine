FactoryBot.define do
  factory :invoice_item do
    association :item, factory: :item
    association :invoice, factory: :invoice
    unit_price { item.unit_price }
    quantity { 10 }
  end
end
