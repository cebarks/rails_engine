class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description

  attribute :unit_price do |o|
    (o.unit_price / 100.to_f).to_s
  end

  attribute :merchant_id do |o|
    o.merchant.id
  end
end
