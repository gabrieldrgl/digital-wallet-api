class TransactionsController < ApplicationController
  def index
    transactions = current_user.transactions.ransack(params[:q]).result
    paginated_transactions = transactions.page(params[:page]).per(params[:per_page])

    render jsonapi: paginated_transactions, class: {
      Transaction: TransactionSerializer
    }, status: :ok
  end

  def create
    transaction = current_user.transactions.new(transaction_params)

    if transaction.save
      render jsonapi: transaction, class: { Transaction: TransactionSerializer }, status: :created
    else
      render jsonapi_errors: transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :description)
  end
end
