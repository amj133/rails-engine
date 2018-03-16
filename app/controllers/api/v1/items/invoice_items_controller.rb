class Api::V1::Items::InvoiceItemsController < ApplicationController
  before_action :set_item

  def index
    render json: @item.invoice_items, each_serializer: InvoiceItemSerializer
  end

  private

    def set_item
      @item = Item.find(params[:item_id])
    end

end
