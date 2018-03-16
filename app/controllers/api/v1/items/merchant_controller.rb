class Api::V1::Items::MerchantController < ApplicationController
  before_action :set_item

  def show
    render json: @item.merchant, serializer: MerchantSerializer
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

end
