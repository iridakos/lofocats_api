class ApplicationController < ActionController::Base
  # CSRF handling for APIS (instead of raising exceptions)
  protect_from_forgery :with => :null_session

  # Whenever an AccessDenied is raised based on the current ability, respond with 401
  rescue_from CanCan::AccessDenied do |exception|
    head 401
  end

  # Retrieve current user
  def current_user
    @current_user ||= resolve_user_by_token
  end

  # Retrieve current authentication token from the request's respective header
  def current_authentication_token
    request.headers['Authorization']
  end

  private

  # Retrieve user from the current authentication token
  def resolve_user_by_token
    token = AuthenticationToken.find_by_token(current_authentication_token) 
    token.try(:user)
  end
end