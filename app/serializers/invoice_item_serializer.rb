class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :unit_price, :quantity, :id

  attribute :invoice_id do |o|
    o.invoice.id
  end

  attribute :item_id do |o|
    o.item.id
  end
end
