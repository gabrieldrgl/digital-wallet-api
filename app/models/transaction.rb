class Transaction < ApplicationRecord
  belongs_to :user

  enum transaction_type: { deposit: 0, withdrawal: 1 }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :sufficient_balance, if: :withdrawal?

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "transaction_type"]
  end


  private

  def sufficient_balance
    if user.balance < amount
      errors.add(:amount, "insufficient balance")
    end
  end
end