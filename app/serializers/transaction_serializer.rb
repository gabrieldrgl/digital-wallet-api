class TransactionSerializer < JSONAPI::Serializable::Resource
  type "transactions"

  attributes :amount, :transaction_type, :description, :created_at

  belongs_to :user
end
