class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all.includes(:items, :invoices))
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]).includes(:items, :invoices))
  end
end
