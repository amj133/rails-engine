class Api::V1::Merchants::MerchantCustomersController < ApplicationController

  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.favorite_customer, serializer: SimpleCustomerSerializer
  end

end
