class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :revenue do |obj|
    obj.revenue
  end
end
