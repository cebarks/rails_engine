class Api::V1::InvoiceItems::SearchController < ApplicationSearchController
  def show
    show_find_helper(InvoiceItem, InvoiceItemSerializer)
  end

  def index
    index_find_helper(InvoiceItem, InvoiceItemSerializer)
  end
end
