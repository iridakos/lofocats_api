require 'spec_helper'

describe 'routes for Sessions' do
  it 'routes post /api/sessions to sessions#create' do
    expect({:post => '/api/sessions'}).to route_to(:controller => 'api/v1/sessions', :action => 'create', :format => :json)
  end

  it 'routes delete /api/sessions to sessions#destroy' do
    expect({:delete => '/api/sessions'}).to route_to(:controller => 'api/v1/sessions', :action => 'destroy', :format => :json)
  end
end