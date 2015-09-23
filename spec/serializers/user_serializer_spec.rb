require 'spec_helper'

describe UserSerializer do
  let(:user) { FactoryGirl.create(:user) }

  subject { UserSerializer.new(user).to_json }

  it 'should serialize the correct attributes' do
    expect(subject).to eq '{"id":1,"email":"test@lofocat.dev","admin":null}'
  end
end
