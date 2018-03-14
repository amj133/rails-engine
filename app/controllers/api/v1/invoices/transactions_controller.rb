class Api::V1::Invoices::TransactionsController < ApplicationController
  before_action :set_invoice

  def index
    render json: @invoice.transactions
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:invoice_id])
    end

end
