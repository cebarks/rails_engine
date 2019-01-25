class Api::V1::Customers::SearchController < ApplicationSearchController
  def show
    show_find_helper(Customer, CustomerSerializer)
  end

  def index
    index_find_helper(Customer, CustomerSerializer)
  end
end
