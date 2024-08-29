require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:transactions) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("userexample.com").for(:email) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "#balance" do
    let(:user) { create(:user) }

    it "calculates the correct balance with deposits and withdrawals" do
      create(:transaction, user: user, transaction_type: :deposit, amount: 100.0)
      create(:transaction, user: user, transaction_type: :withdrawal, amount: 50.0)
      expect(user.balance).to eq(50.0)
    end

    it "returns zero if no transactions exist" do
      expect(user.balance).to eq(0.0)
    end
  end
end