class UserSerializer < JSONAPI::Serializable::Resource
  type "User"

  attributes :name, :email

  meta do
    { token: @token } if @token
  end
end
