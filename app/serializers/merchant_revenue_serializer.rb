class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :id do |o|
    o.id
  end

  attribute :revenue do |o|
    require 'pry'; binding.pry
    (o.revenue / 100.to_f).to_s
  end
end
