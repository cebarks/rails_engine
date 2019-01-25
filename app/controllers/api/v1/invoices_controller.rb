class Api::V1::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.all.includes(:invoice_items, :transactions))
  end

  def show
    render json: InvoiceSerializer.new(Invoice.includes(:invoice_items, :transactions).find(params[:id]))
  end
end
