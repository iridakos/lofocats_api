# Serialized attributes for a Session consisting of the user & authentication token
class UserSessionSerializer < ActiveModel::Serializer

  # The signed in user
  has_one :user
  
  # The created authentication token
  has_one :authentication_token

  # Extracts the user from the given object (hash)
  def user
    object[:user]
  end

  # Extracts the authentication token from the given object (hash)
  def authentication_token
    object[:authentication_token]
  end
end
