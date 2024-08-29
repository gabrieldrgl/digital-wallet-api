class AuthController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def signin
    user = User.find_by!(email: signin_params[:email])

    if user.authenticate(signin_params[:password])
      @token = encode_token(user_id: user.id)

      render jsonapi: user, class: {
        User: UserSerializer
      }, meta: { token: @token }, status: :accepted
    else
      render jsonapi_errors: [{ title: "Unauthorized", detail: "Incorrect password" }], status: :unauthorized
    end
  end

  private

  def signin_params
    params.permit(:email, :password)
  end

  def handle_record_not_found(e)
    render jsonapi_errors: [{ title: "Not Found", detail: "User doesn't exist" }], status: :unauthorized
  end
end
