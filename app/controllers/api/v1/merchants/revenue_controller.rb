class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    render json: {data: {revenue: Merchant.find(params[:merchant_id]).revenue(params[:date])}}
  end
end
