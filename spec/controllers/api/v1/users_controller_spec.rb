require 'spec_helper'

describe Api::V1::UsersController do
  describe "GET #index" do
    before do
      FactoryGirl.create(:user)
      FactoryGirl.create(:admin_user)
      
      expect(controller).to receive(:authorize!).with(:read_all, User)

      get :index
    end

    it { should respond_with 200 }
    
    it 'should respond with users information' do
      expect(json_response.to_json).to eq User.all.map{|user| UserSerializer.new(user)}.to_json
    end
  end

  describe "GET #show" do
    let(:user_id) { nil }

    context 'for existent user' do
      let(:user) { FactoryGirl.create :user }
      let(:user_id) { user.id }

      before do
        expect(controller).to receive(:authorize!).with(:read, User).once

        get :show, :id => user_id
      end

      it { should respond_with 200 }

      it 'should respond with user information' do
        expect(json_response.to_json).to eq UserSerializer.new(user).to_json
      end
    end

    context 'for non existent user' do
      let(:user_id) { 1 }

      before do
        expect(controller).to receive(:authorize!).with(:read, User).never

        get :show, :id => user_id
      end

      it { should respond_with 404 }
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:user_attributes) { FactoryGirl.attributes_for :user }
      
      before(:each) do
        allow(controller).to receive(:authorize!).with(:create, User).once
        
        post :create, { user: user_attributes }
      end

      it { should respond_with 201 }

      it "renders with user information" do
        expect(json_response.to_json).to eql UserSerializer.new(User.first).to_json
      end
    end

    context "with invalid parameters" do
      let(:invalid_user_attributes) { 
        { 
          password: "1",
          password_confirmation: "10"
        }
      }

      before(:each) do
        expect(controller).to receive(:authorize!).with(:create, User).once
        
        post :create, { user: invalid_user_attributes }
      end

      it { should respond_with 422 }

      it "renders the json errors" do
        user = User.new(invalid_user_attributes)
        expect(user).to be_invalid
        expect(json_response[:errors].to_json).to eq user.errors.to_json
      end
    end
  end

  describe "PUT/PATCH #update" do
    context 'for existent user' do
      let(:user) { FactoryGirl.create :user }
      
      context "with valid parameters" do
        before do
          expect(controller).to receive(:authorize!).with(:update, user).once

          patch :update, id: user.id, user: { email: "test@lofocats.com" }
        end

        it { should respond_with 200 }

        it "responds with user information" do
          expect(json_response.to_json).to eql UserSerializer.new(User.first).to_json
        end
      end

      context "with invalid parameters" do
        before do
          expect(controller).to receive(:authorize!).with(:update, user).once

          patch :update, id: user.id, user: { email: "waaat.com" }
        end

        it { should respond_with 422 }

        it "renders the json errors" do
          expect(json_response[:errors][:email]).to include "is not an email"
        end
      end
    end

    context 'for non-existent user' do
      before do
        expect(controller).not_to receive(:authorize!)

        put :update, :id => 2, :user => { :email => 'test@lofocats.com' }
      end

      it { should respond_with 404 }
    end
  end

  describe "DELETE #destroy" do
    context 'for existent user' do
      let(:user) { FactoryGirl.create :user }
      
      before(:each) do
        expect(controller).to receive(:authorize!).with(:destroy, user)

        delete :destroy, id: user.id
      end

      it { should respond_with 204 }
    end

    context 'when user tries to delete his account' do
      let(:user) { FactoryGirl.create :user }

      before(:each) do
        expect(controller).to receive(:authorize!).with(:destroy, user)
        allow(controller).to receive(:current_user).and_return(user)

        delete :destroy, id: user.id
      end

      it { should respond_with 422 }
    end

    context 'for non-existent user' do
      before(:each) do
        expect(controller).not_to receive(:authorize!)

        delete :destroy, id: 1
      end

      it { should respond_with 404 }
    end
  end
end
