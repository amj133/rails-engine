class Api::V1::Merchants::MerchantItemsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.items, each_serializer: ItemSerializer
  end

end
