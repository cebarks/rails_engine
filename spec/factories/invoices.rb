FactoryBot.define do
  factory :invoice do
    status { "shipped" }
    association :customer, factory: :customer
    association :merchant, factory: :merchant

    transient do
      items_count { 5 }
      transaction_count { 1 }
    end

    after(:create) do |invoice, eval|
      item = create(:item, merchant: invoice.merchant)
      create_list(:invoice_item, eval.items_count, item: item, invoice: invoice)
    end

    after(:create) do |invoice, eval|
      create_list(:transaction, eval.transaction_count, invoice: invoice)
    end
  end
end
