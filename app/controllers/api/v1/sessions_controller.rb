class Api::V1::SessionsController < ApplicationController
  
  # POST '/api/sessions'
  def create
    authorize! :create, :session

    # Fail with missing params
    handle_authentication_failure and return unless params[:session].present?

    email = params[:session][:email]
    password = params[:session][:password]
    user = User.find_by_email(email)

    if user.present? && user.authenticate(password)
      # Generate a new authentication token
      token = user.generate_new_token!
      user.save

      render :json => { :user => user, :authentication_token => token },
             :serializer => UserSessionSerializer,
             :status => 201
    else
      handle_authentication_failure
    end
  end

  # DELETE '/api/sessions'
  def destroy
    authorize! :destroy, :session

    token = AuthenticationToken.find_by_token(current_authentication_token)
    
    if token.present?
      token.destroy
      head 204
    else
      head 404
    end
  end

  private

  # Heads 401
  def handle_authentication_failure
    head 401
  end
end
