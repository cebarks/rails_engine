class Api::V1::Items::SearchController < ApplicationSearchController
  def show
    show_find_helper(Item, ItemSerializer)
  end

  def index
    index_find_helper(Item, ItemSerializer)
  end
end
