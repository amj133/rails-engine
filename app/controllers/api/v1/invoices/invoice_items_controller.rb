class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  before_action :set_invoice

  def index
    render json: @invoice.invoice_items
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:invoice_id])
    end

end
