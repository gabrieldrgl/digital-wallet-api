class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def create
    user = User.create!(user_params)
    @token = encode_token(user_id: user.id)

    render jsonapi: user, class: {
      User: UserSerializer
    }, meta: { token: @token }, status: :created
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def handle_invalid_record(e)
    render jsonapi_errors: e.record.errors, status: :unprocessable_entity
  end
end
