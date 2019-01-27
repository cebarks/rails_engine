class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :credit_card_number, :result

  attribute :invoice_id do |o|
    o.invoice.id
  end
end
