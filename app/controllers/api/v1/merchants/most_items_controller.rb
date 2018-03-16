class Api::V1::Merchants::MostItemsController < ApplicationController
  before_action :set_merchants

  def index
    render json: @merchants, each_serializer: MerchantSerializer
  end

  private

  def set_merchants
    @merchants = Merchant.merchants_with_most_items(params['quantity'].to_i)
  end

end
