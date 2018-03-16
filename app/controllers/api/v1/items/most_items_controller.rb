class Api::V1::Items::MostItemsController < ApplicationController
  before_action :set_most_items

  def index
    render json: @most_items, each_serializer: ItemSerializer
  end

  private

  def set_most_items
    @most_items = Item.most_items_sold(params['quantity'].to_i)
  end

end
