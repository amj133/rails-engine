class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  before_action :set_customer

  def show
    render json: @customer.favorite_merchant
  end

  private

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

end
