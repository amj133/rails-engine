class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: Merchant.top_merchants_by_revenue(revenue_params["quantity"].to_i)
  end

  private

  def revenue_params
    params.permit(:quantity)
  end

end
