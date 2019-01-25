class Api::V1::Merchants::SearchController < ApplicationSearchController
  def show
    show_find_helper(Merchant, MerchantSerializer)
  end

  def index
    index_find_helper(Merchant, MerchantSerializer)
  end
end
