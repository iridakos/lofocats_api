require 'spec_helper'

describe Api::V1::SessionsController do
  describe "POST '/api/sessions'" do
    let(:user) { FactoryGirl.create :user }

    before do
      expect(controller).to receive(:authorize!).with(:create, :session)

      post :create, { :session => credentials }
    end

    context 'without session parameters' do
      let(:credentials) { nil }
      it { should respond_with 401 }
    end

    context 'with invalid credentials' do
      let(:credentials) { 
        {
          :email => user.email,
          :password => 'foofoo'
        }
      }

      it { should respond_with 401 }
    end

    context 'with valid credentials' do
      let(:credentials) {
        {
          :email => user.email,
          :password => '12345678'
        }
      }

      it { should respond_with 201 }
      
      it 'should respond with user and authentication token information' do
        expect(json_response.to_json).to eq UserSessionSerializer.new({:user => user, :authentication_token => user.authentication_tokens.first}).to_json
      end
    end
  end

  describe "DELETE '/api/sessions'" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:authentication_token) { FactoryGirl.create(:authentication_token, :user => user, :token => 'ABC') }
    let(:current_authentication_token) { nil }

    before do
      expect(controller).to receive(:authorize!).with(:destroy, :session)
      allow(controller).to receive(:current_authentication_token).and_return(current_authentication_token)

      delete :destroy
    end

    context 'for non existent token' do
      let(:current_authentication_token) { 'DEF' }

      it { should respond_with 404 }
    end

    context 'for existent token' do
      let(:current_authentication_token) { 'ABC' }

      it { should respond_with 204 }

      it 'should destroy the token' do
        expect(AuthenticationToken.count).to eq 0
      end
    end
  end
end