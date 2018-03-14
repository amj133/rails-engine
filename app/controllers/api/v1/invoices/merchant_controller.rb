class Api::V1::Invoices::MerchantController < ApplicationController

  before_action :set_invoice

  def show
    render json: @invoice.merchant, serializer: SimpleMerchantSerializer
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:invoice_id])
    end

end
