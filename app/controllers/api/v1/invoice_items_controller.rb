class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItem.all, each_serializer: InvoiceItemSerializer
  end

  def show
    render json: InvoiceItem.find(params[:id]), serializer: InvoiceItemSerializer
  end

end
