require "rails_helper"

RSpec.describe AuthController, type: :request do
  let(:valid_attributes) { { email: "user@example.com", password: "password123" } }
  let(:invalid_attributes) { { email: "user@example.com", password: "wrongpassword" } }
  let!(:user) { create(:user) }

  describe "POST /signin" do
    context "with valid credentials" do
      it "authenticates the user and returns a token" do
        post "/signin", params: valid_attributes
        expect(response).to have_http_status(:accepted)
        expect(response.body).to include("token")
      end
    end

    context "with invalid credentials" do
      it "does not authenticate the user and returns an error" do
        post "/signin", params: invalid_attributes
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include("Unauthorized")
      end
    end
  end
end
