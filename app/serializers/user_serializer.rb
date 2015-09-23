class UserSerializer < ActiveModel::Serializer
  # Serialized attributes for the User
  attributes :id, :email, :admin
end
