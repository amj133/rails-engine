class Api::V1::Items::BestDayController < ApplicationController
  before_action :set_item

  def show
    render json: @item.best_day, serializer: BestDaySerializer
  end

  private

    def set_item
      @item = Item.find(params[:item_id])
    end

end
