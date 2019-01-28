class ApplicationSearchController < ApplicationController
  def show_find_helper(clazz, serializer)
    case search_type = search_params(clazz).keys.first
    when "id"
      render json: serializer.new(clazz.find(params[:id]))
    when "name"
      render json: serializer.new(clazz.where("name ILIKE '#{search_params(clazz)[search_type]}'").first)
    when "first_name"
      render json: serializer.new(clazz.where("first_name ILIKE '#{search_params(clazz)[search_type]}'").first)
    when "last_name"
      render json: serializer.new(clazz.where("last_name ILIKE '#{search_params(clazz)[search_type]}'").first)
    # when "unit_price"
    #   render json: serializer.new(clazz.where(unit_price: (search_params(clazz)[search_type].to_f * 100).to_i).first)
    else
      result = clazz.where(search_type.to_sym => search_params(clazz)[search_type]).first
      render json: serializer.new(result)
    end
  end

  def index_find_helper(clazz, serializer)
    case search_type = search_params(clazz).keys.first
    when "id"
      render json: serializer.new(clazz.find(params[:id]))
    when "name"
      render json: serializer.new(clazz.where("name ILIKE '#{search_params(clazz)[search_type]}'"))
    when "first_name"
      render json: serializer.new(clazz.where("first_name ILIKE '#{search_params(clazz)[search_type]}'"))
    when "last_name"
      render json: serializer.new(clazz.where("last_name ILIKE '#{search_params(clazz)[search_type]}'"))
    # when "unit_price"
      # render json: serializer.new(clazz.where(unit_price: search_params(clazz)[search_type].to_f * 100))
    else
      render json: serializer.new(clazz.where(search_type.to_sym => search_params(clazz)[search_type]))
    end
  end

  private

  def search_params(clazz)
    parms = clazz.columns.map(&:name)

    params.permit(parms)
  end
end
