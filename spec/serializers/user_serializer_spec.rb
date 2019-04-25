require 'spec_helper'

describe UserSerializer do
  let(:user) { FactoryGirl.create(:user) }

  subject { UserSerializer.new(user).to_json }

  it 'should serialize the correct attributes' do
    expect(subject).to match(/^{"id":\d+,"email":"test@lofocat.dev","admin":null}$/)
  end
end
