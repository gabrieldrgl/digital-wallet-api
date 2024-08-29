class UserSerializer < JSONAPI::Serializable::Resource
  type "users"

  attributes :name, :email, :balance

  meta do
    { token: @token } if @token
  end
end
