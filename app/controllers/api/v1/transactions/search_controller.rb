class Api::V1::Transactions::SearchController < ApplicationSearchController
  def show
    show_find_helper(Transaction, TransactionSerializer)
  end

  def index
    index_find_helper(Transaction, TransactionSerializer)
  end
end
