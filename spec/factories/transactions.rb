FactoryBot.define do
  factory :transaction do
    credit_card_number { "4444 4444 4444 4444" }
    credit_card_expiration_date { "12/8/1997" }
    result { "success" }

    association :invoice, factory: :invoice, transaction_count: 0

    trait :failed do
      result { "failed" }
    end
  end
end
