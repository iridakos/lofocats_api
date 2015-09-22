require 'spec_helper'

describe 'routes for Cat entries' do
  it 'routes /api/cat_entries to cat_entries#index' do
    expect({:get => '/api/cat_entries'}).to route_to(:controller => 'api/v1/cat_entries', :action => 'index', :format => :json)
  end

  it 'routes /api/cat_entries/:id to cat_entries#show' do
    expect({:get => '/api/cat_entries/1'}).to route_to(:controller => 'api/v1/cat_entries', :action => 'show', :id => '1', :format => :json)
  end

  it 'routes post /api/cat_entries to cat_entries#create' do
    expect({:post => '/api/cat_entries'}).to route_to(:controller => 'api/v1/cat_entries', :action => 'create', :format => :json)
  end

  it 'routes put /api/cat_entries/:id to cat_entries#update' do
    expect({:put => '/api/cat_entries/1'}).to route_to(:controller => 'api/v1/cat_entries', :action => 'update', :id => '1', :format => :json)
  end

  it 'routes delete /api/cat_entries/:id to cat_entries#destroy' do
    expect({:delete => '/api/cat_entries/1'}).to route_to(:controller => 'api/v1/cat_entries', :action => 'destroy', :id => '1', :format => :json)
  end
end