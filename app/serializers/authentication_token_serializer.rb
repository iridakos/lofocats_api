class AuthenticationTokenSerializer < ActiveModel::Serializer
  # Serialized attributes for the authentication token
  attributes :token, :expires_at
end
