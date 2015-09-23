class Api::V1::UsersController < ApplicationController
  
  # Load the user based on the id parameter
  before_filter :load_user, :only => [:show, :update, :destroy]

  # GET '/api/users'
  def index
    authorize! :read_all, User

    render :json => User.all
  end

  # GET '/api/users/:id'
  def show
    authorize! :read, User
    
    render :json => @user 
  end

  # POST '/api/users'
  def create
    authorize! :create, User
    
    user = User.new user_params
    
    if user.save
      render :json => user, :status => 201
    else
      render :json => { :errors => user.errors }, :status => 422
    end
  end

  # PUT/PATCH '/api/users/:id'
  def update
    authorize! :update, @user

    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  # DELETE '/api/users/:id'
  def destroy
    authorize! :destroy, @user

    if current_user != @user
      @user.destroy

      head 204
    else
      head 422
    end
  end

  private

  # Retrieves the user with the parameter id
  def load_user
    @user = User.find_by_id(params[:id])
    head 404 and return unless @user.present?
  end

  # Define allowed parameters
  def user_params
    params.require(:user).permit(:email,
                                 :admin,
                                 :password,
                                 :password_confirmation)
  end
end
