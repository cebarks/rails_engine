class Api::V1::Invoices::SearchController < ApplicationSearchController
  def show
    show_find_helper(Invoice, InvoiceSerializer)
  end

  def index
    index_find_helper(Invoice, InvoiceSerializer)
  end
end
