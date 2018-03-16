class Api::V1::Merchants::FinderController < ApplicationController

  def index
    render json: Merchant.where(merchant_params), each_serializer: MerchantSerializer
  end

  def show
    render json: Merchant.find_by(merchant_params), serializer: MerchantSerializer
  end

  private

    def merchant_params
      params.permit(:name, :created_at, :updated_at, :id)
    end

end
