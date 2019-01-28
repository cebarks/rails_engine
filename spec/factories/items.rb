FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "Item #{n}"
    end

    sequence :description do |n|
      "Item Description #{n}"
    end
    unit_price { 5 }
    association :merchant, factory: :merchant
  end
end
