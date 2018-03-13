class Api::V1::Merchants::MerchantRevenueController < ApplicationController

  def index
    render json: Merchant.merchant_revenue(params[:id])
  end
end
