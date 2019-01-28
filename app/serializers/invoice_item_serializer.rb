class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quantity, :id

  attribute :unit_price do |o|
    (o.unit_price / 100.to_f).to_s
  end

  attribute :invoice_id do |o|
    o.invoice.id
  end

  attribute :item_id do |o|
    o.item.id
  end
end
