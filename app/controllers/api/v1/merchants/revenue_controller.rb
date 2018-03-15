class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    if params['date']
      render json: Merchant.find(params[:merchant_id]).revenue_by_date(params['date']), serializer: RevenueSerializer
    else
      render json: Merchant.find(params[:merchant_id]).revenue, serializer: RevenueSerializer
    end
  end

end
