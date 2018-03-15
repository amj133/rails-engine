class Api::V1::Merchants::MerchantsRevenueController < ApplicationController

  def show
    render json: {"total_revenue" => Transaction.total_revenue_for_date(params["date"]).to_s}
  end

end
