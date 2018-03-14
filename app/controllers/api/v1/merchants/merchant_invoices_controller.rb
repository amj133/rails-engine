class Api::V1::Merchants::MerchantInvoicesController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.invoices, each_serializer: SimpleInvoiceSerializer
  end

end
