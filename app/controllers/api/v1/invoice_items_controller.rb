class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all.includes(:item, :invoice))
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.includes(:item, :invoice).find(params[:id]))
  end
end
