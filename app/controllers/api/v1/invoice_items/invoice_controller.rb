class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  before_action :set_invoice_item

  def show
    render json: @invoice_item.invoice
  end

  private

    def set_invoice_item
      @invoice_item = InvoiceItem.find(params[:invoice_item_id])
    end

end
