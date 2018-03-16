class Api::V1::Invoices::SearchController < ApplicationController

  def index
    render json: Invoice.where(invoice_params), each_serializer: InvoiceSerializer
  end

  def show
    render json: Invoice.find_by(invoice_params), serializer: InvoiceSerializer
  end

  private

    def invoice_params
      params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
    end

end
