require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      raise CanCan::AccessDenied
    end
  end

  describe 'Handling of CanCan Access denied exceptions' do
    before do
      get :index
    end

    it { should respond_with 401 }
  end

  describe '#current_user' do
    let(:user) { FactoryGirl.build(:user) }

    it 'should keep the user previously resolved by the authentication token' do
      expect(controller).to receive(:resolve_user_by_token).once.and_return(user)
      
      expect(controller.current_user).to eq user
      expect(controller.current_user).to eq user
    end
  end

  describe '#current_authentication_token' do
    let(:token) { 'ABCD' }
    it 'should return the request authorization header' do
      request.headers['Authorization'] = token

      expect(controller.current_authentication_token).to eq token
    end
  end

  describe '#resolve_user_by_token' do
    context 'without token' do
      it 'should return nil' do
        expect(AuthenticationToken).to receive(:find_by_token).and_return(nil)

        expect(controller.send(:resolve_user_by_token)).to be_nil
      end
    end
    
    context 'with token' do
      it 'should return the token user' do
        user = FactoryGirl.create(:user)
        authentication_token = FactoryGirl.create(:authentication_token, :user => user)

        expect(AuthenticationToken).to receive(:find_by_token).and_return(authentication_token)

        expect(controller.send(:resolve_user_by_token)).to eq user
      end
    end
  end
end