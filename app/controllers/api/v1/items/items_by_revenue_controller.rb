class Api::V1::Items::ItemsByRevenueController < ApplicationController
  before_action :set_top_items

  def index
    render json: @top_items, each_serializer: ItemSerializer
  end

  private

  def set_top_items
    @top_items = Item.top_items_by_total_revenue(params["quantity"].to_i)
  end

end
