class ApplicationSearchController < ApplicationController
  def show_find_helper(clazz, serializer)
    case search_type = search_params(clazz).keys.first
    when "id"
      render json: serializer.new(clazz.find(search_params(clazz)[search_type]))
    when "name"
      render json: serializer.new(clazz.where("name ILIKE '#{search_params(clazz)[search_type]}'").first)
    else
      render json: serializer.new(clazz.where(search_type.to_sym => search_params(clazz)[search_type]).first)
    end
  end

  def index_find_helper(clazz, serializer)
    case search_type = search_params(clazz).keys.first
    when "id"
      render json: serializer.new(clazz.find(search_params(clazz)[search_type]))
    when "name"
      render json: serializer.new(clazz.where("name ILIKE '#{search_params(clazz)[search_type]}'"))
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
