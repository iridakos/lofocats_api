require 'spec_helper'

describe 'routes for Users' do
  it 'routes /api/users/:id to users#show' do
    expect({:get => '/api/users/1'}).to route_to(:controller => 'api/v1/users', :action => 'show', :id => '1', :format => :json)
  end

  it 'routes post /api/users to users#create' do
    expect({:post => '/api/users'}).to route_to(:controller => 'api/v1/users', :action => 'create', :format => :json)
  end

  it 'routes put /api/users/:id to users#update' do
    expect({:put => '/api/users/1'}).to route_to(:controller => 'api/v1/users', :action => 'update', :id => '1', :format => :json)
  end

  it 'routes delete /api/users/:id to users#destroy' do
    expect({:delete => '/api/users/1'}).to route_to(:controller => 'api/v1/users', :action => 'destroy', :id => '1', :format => :json)
  end
end