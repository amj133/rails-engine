class Api::V1::InvoiceItems::SearchController < ApplicationController
  before_action :price_to_cents, only: [:show, :index]

  def index
    render json: InvoiceItem.where(invoice_items_params), each_serializer: InvoiceItemSerializer
  end

  def show
    render json: InvoiceItem.find_by(invoice_items_params), serializer: InvoiceItemSerializer
  end

  private

  def invoice_items_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

  def price_to_cents
    params["unit_price"] = invoice_items_params["unit_price"].to_f * 100 unless params["unit_price"].nil?
  end

end
