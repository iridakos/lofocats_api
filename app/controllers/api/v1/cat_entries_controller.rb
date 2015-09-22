class Api::V1::CatEntriesController < ApplicationController
  # Load the cat entry with the given id
  before_filter :load_cat_entry, :only => [:show, :update, :destroy]

  # GET '/api/cat_entries'
  def index
    authorize! :read, CatEntry

    @cat_entries = CatEntry.all

    render :json => @cat_entries
  end

  # GET '/api/cat_entries/:id'
  def show
    authorize! :read, CatEntry

    render :json => @cat_entry
  end

  # POST '/api/cat_entries'
  def create
    authorize! :create, CatEntry
    
    @cat_entry = current_user.cat_entries.build cat_entry_params

    if @cat_entry.save
      render :json => @cat_entry, :status => 201
    else
      respond_with_invalid_cat_entry_errors
    end
  end

  # PUT/PATCH '/api/cat_entries/:id'
  def update
    authorize! :update, @cat_entry

    if @cat_entry.update(cat_entry_params)
      render json: @cat_entry, status: 200
    else
      respond_with_invalid_cat_entry_errors
    end
  end

  # DELETE '/api/cat_entries'
  def destroy
    authorize! :destroy, @cat_entry
    @cat_entry.destroy

    head 204
  end

  protected

  # Renders validation errors of a cat entry with status 422
  def respond_with_invalid_cat_entry_errors
    render json: { errors: @cat_entry.errors }, status: 422
  end

  # Loads the cat entry with the given id to the @cat_entry instance variable
  def load_cat_entry
    @cat_entry = CatEntry.find(params[:id]) if params[:id].present?
  end

  # Defined valid params
  def cat_entry_params
    params.require(:cat_entry).permit(:breed,
                                      :color,
                                      :longitude,
                                      :latitude,
                                      :contact_phone,
                                      :contact_email,
                                      :event_date,
                                      :entry_type,
                                      :resolved,
                                      :chip,
                                      :photo_url)
  end
end
