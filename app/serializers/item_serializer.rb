class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :unit_price, :name, :description

  attribute :unit_price do |o|
    o.unit_price.id / 100.to_f
  end
end
