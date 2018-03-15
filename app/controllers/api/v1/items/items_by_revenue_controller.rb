class Api::V1::Items::ItemsByRevenueController < ApplicationController

  def index
    render json: Item.top_items_by_total_revenue(params["quantity"].to_i), each_serializer: ItemSerializer
  end

end
