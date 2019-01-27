class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status, :id

  # attribute :invoice_items do |o|
  #   o.invoice_items.map(&:id)
  # end
  # attribute :transactions do |o|
  #   o.transactions.map(&:id)
  # end

  attribute :merchant_id do |o|
    o.merchant.id
  end

  attribute :customer_id do |o|
    o.customer.id
  end
end
