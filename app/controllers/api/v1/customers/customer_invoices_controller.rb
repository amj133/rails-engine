class Api::V1::Customers::CustomerInvoicesController < ApplicationController
  before_action :set_customer

  def index
    render json: @customer.invoices
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

end
