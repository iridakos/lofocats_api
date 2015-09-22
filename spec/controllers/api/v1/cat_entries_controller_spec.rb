require 'spec_helper'

describe Api::V1::CatEntriesController do
  describe "GET #index" do
    before do
      3.times do |i|
        FactoryGirl.create(:cat_entry, :breed => "Breed #{i}", :user => FactoryGirl.create(:user,
         :email => "user#{i}@lofocats.com"))
      end

      2.times do |i|
        FactoryGirl.create(:cat_entry, :breed => "Breed #{3 + i}", :resolved => true, :user => FactoryGirl.create(:user,
          :email => "user#{3 + i}@lofocats.com"))
      end

      expect(controller).to receive(:authorize!).with(:read, CatEntry).once

      get :index
    end

    it { should respond_with 200 }

    describe '@assigns' do
      subject { assigns(:cat_entries) }

      it "should have 3 items" do
        expect(subject.size).to eq 3
      end
    end
  end

  describe "GET '/api/cat_entries/:id'" do
    let(:cat_entry) { FactoryGirl.create(:cat_entry) }

    before do
      expect(controller).to receive(:authorize!).with(:read, CatEntry).once.and_call_original

      get :show, :id => cat_entry.id
    end

    it { should respond_with 200 }

    it 'should respond with the serialized cat entry' do
      expect(json_response.to_json).to eq CatEntrySerializer.new(cat_entry).to_json
    end
  end

  describe "POST #create" do
    let(:user) { FactoryGirl.create(:user) }
    let(:cat_entry_params) { nil }
    
    before do
      expect(controller).to receive(:authorize!).with(:create, CatEntry)
      allow(controller).to receive(:current_user).and_return(user)

      post :create, :cat_entry => cat_entry_params
    end

    context 'with invalid parameters' do
      let(:cat_entry_params) { FactoryGirl.attributes_for :new_cat_entry, :breed => nil }

      it { should respond_with 422 }

      it 'should respond with errors' do
        invalid_cat_entry = CatEntry.new(cat_entry_params.merge(:user => user))

        expect(invalid_cat_entry).to be_invalid
        expect(json_response[:errors]).to match(invalid_cat_entry.errors.as_json)
      end
    end

    context 'with valid parameters' do
      let(:cat_entry_params) {  FactoryGirl.attributes_for :cat_entry, :user => nil }

      it { should respond_with 201 }

      it 'should respond with the created cat entry' do
        expect(CatEntry.count).to eq 1

        expect(json_response.to_json).to eq CatEntrySerializer.new(CatEntry.first).to_json
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:cat_entry_params) { nil }
    let(:user) { FactoryGirl.create(:user) }
    let(:cat_entry) { FactoryGirl.create :cat_entry, :user => user }

    before do
      expect(controller).to receive(:authorize!).with(:update, cat_entry).once.and_call_original
      allow(controller).to receive(:current_user).and_return(user)

      put :update, :id => cat_entry.id, :cat_entry => cat_entry_params
    end

    context 'with invalid parameters' do
      let(:cat_entry_params) { FactoryGirl.attributes_for :new_cat_entry, :breed => nil }

      it { should respond_with 422 }

      it 'should respond with errors' do
        expect(json_response[:errors][:breed]).to eq ["can't be blank"]
      end
    end

    context 'with valid parameters' do
      let(:cat_entry_params) {  
        FactoryGirl.attributes_for :new_cat_entry, :breed => 'European'
      }

      it { should respond_with 200 }

      it 'should respond with the created cat entry' do
        cat_entry.reload
        expect(json_response.to_json).to eq CatEntrySerializer.new(cat_entry).to_json
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { FactoryGirl.create(:user) }
    let(:cat_entry) { FactoryGirl.create(:cat_entry, :user => user) }

    before do
      expect(controller).to receive(:authorize!).with(:destroy, cat_entry)
      allow(controller).to receive(:current_user).and_return(user)

      delete :destroy, :id => cat_entry.id
    end

    it { should respond_with 204 }

    it 'should delete the entry' do
      expect(CatEntry.count).to eq 0
    end
  end
end