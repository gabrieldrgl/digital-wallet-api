require "rails_helper"

RSpec.describe Transaction, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }

    context "when transaction_type is withdrawal" do
      let(:user) { create(:user) }

      it "is valid if balance is sufficient" do
        create(:transaction, user: user, transaction_type: :deposit, amount: 100.0)
        transaction = build(:transaction, user: user, transaction_type: :withdrawal, amount: 50.0)
        expect(transaction).to be_valid
      end

      it "is invalid if balance is insufficient" do
        transaction = build(:transaction, user: user, transaction_type: :withdrawal, amount: 50.0)
        expect(transaction).not_to be_valid
        expect(transaction.errors[:amount]).to include("insufficient balance")
      end
    end
  end

  describe ".ransackable_attributes" do
    it "allows filtering by created_at and transaction_type" do
      expect(Transaction.ransackable_attributes).to include("created_at", "transaction_type")
    end
  end
end