require "rails_helper"

RSpec.describe TransactionsController, type: :request do
  let!(:user) { create(:user) }
  let(:valid_attributes) { { amount: 100.0, transaction_type: "deposit", description: "Deposit" } }
  let(:invalid_attributes) { { amount: -100.0, transaction_type: "deposit" } }
  let!(:transaction) { create(:transaction, user: user) }

  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

  describe "GET /transactions" do
    it "returns a list of transactions for the current user" do
      get "/transactions"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("transactions")
    end
  end

  describe "POST /transactions" do
    context "with valid parameters" do
      it "creates a new Transaction" do
        expect {
          post "/transactions", params: { transaction: valid_attributes }
        }.to change(Transaction, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to include("Deposit")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Transaction" do
        expect {
          post "/transactions", params: { transaction: invalid_attributes }
        }.to change(Transaction, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("errors")
      end
    end
  end
end
