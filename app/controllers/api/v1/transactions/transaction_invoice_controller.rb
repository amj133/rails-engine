class Api::V1::Transactions::TransactionInvoiceController < ApplicationController

  def show
    transaction = Transaction.find(params[:transaction_id])
    render json: transaction.invoice, serializer: InvoiceSerializer
  end

end
