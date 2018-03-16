class Api::V1::Items::SearchController < ApplicationController
  before_action :price_to_cents, only: [:show, :index]

  def index
    render json: Item.where(item_params), each_serializer: ItemSerializer
  end

  def show
    render json: Item.find_by(item_params), serializer: ItemSerializer
  end

  private

  def item_params
    params.permit(:id, :name, :description,
                  :unit_price, :merchant_id,
                  :created_at, :updated_at)
  end

  def price_to_cents
    params["unit_price"] = (item_params["unit_price"].to_f * 100).round(2) unless params["unit_price"].nil?
  end

end
