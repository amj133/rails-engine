class Api::V1::Customers::CustomerTransactionsController < ApplicationController
  before_action :set_transactions

  def index
    render json: @transactions, each_serializer: TransactionSerializer
  end

  private

  def set_transactions
    @transactions = Transaction.transactions_by_customer(params[:customer_id])
  end

end
