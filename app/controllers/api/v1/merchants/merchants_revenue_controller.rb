class Api::V1::Merchants::MerchantsRevenueController < ApplicationController
  before_action :set_total_revenue

  def show
    render json: @total_revenue
  end

  private

  def set_total_revenue
    @total_revenue = {"total_revenue" => Transaction.total_revenue_for_date(params["date"]).to_s}
  end

end
