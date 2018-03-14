class Api::V1::Invoices::CustomerController < ApplicationController
  before_action :set_invoice

  def show
    render json: @invoice.customer
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:invoice_id])
    end

end
