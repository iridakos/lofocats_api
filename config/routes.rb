Rails.application.routes.draw do
  namespace :api, :defaults => { :format => :json } do
    # Serve and default to v1 version of the API
    scope :module => :v1, :constraints => ApiConstraints.new(version: 1, default: true) do
      # Users
      resources :users, :only => [:index, :show, :create, :update, :destroy]

      # Sessions
      resource :sessions, :only => [:create, :destroy]

      # Cat entries
      resources :cat_entries, :only => [:index, :show, :create, :update, :destroy]
    end
  end
end
