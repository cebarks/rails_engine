class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    # render json: MerchantRevenueSerializer.new(Merchant.find(params[:merchant_id]))
    render json: {data: {id: params[:merchant_id], attributes: {revenue: (Merchant.find(params[:merchant_id]).revenue(params[:date]) / 100.to_f).to_s}}}
  end
end
