require "rails_helper"

RSpec.describe UsersController, type: :request do
  let(:valid_attributes) { { name: "Test User", email: "user@example.com", password: "password123" } }
  let(:invalid_attributes) { { name: "", email: "invalid", password: "short" } }
  let(:user) { create(:user) }

  describe "POST /signup" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post "/signup", params: valid_attributes
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to include("Test User")
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post "/signup", params: invalid_attributes
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("errors")
      end
    end
  end

  describe "GET /balance" do
    before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }

    it "returns the balance of the current user" do
      get "/balance"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("balance")
    end
  end
end
