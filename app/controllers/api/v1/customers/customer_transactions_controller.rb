class Api::V1::Customers::CustomerTransactionsController < ApplicationController

  def index
    render json: Transaction.transactions_by_customer(params[:customer_id]), each_serializer: TransactionSerializer
  end

end
