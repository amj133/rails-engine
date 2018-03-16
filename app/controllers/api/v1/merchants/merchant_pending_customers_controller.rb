class Api::V1::Merchants::MerchantPendingCustomersController < ApplicationController
  before_action :set_merchant

  def index
    render json: @merchant.customers_with_pending_invoices, each_serializer: CustomerSerializer
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

end
