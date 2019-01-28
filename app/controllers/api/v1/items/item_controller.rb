class Api::V1::Items::ItemController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.most_items(params[:quantity]))
  end
end
