require 'spec_helper'

describe UserSessionSerializer do
  let(:user) { FactoryGirl.build(:user) }
  let(:authentication_token) { FactoryGirl.build(:authentication_token, :user => user) }
  let(:session_information) { {:user => user, :authentication_token => authentication_token} }

  subject { UserSessionSerializer.new(session_information).to_json }

  it 'should serialize the correct attributes' do
    expect(subject).to eq '{"user":{"id":null,"email":"test@lofocat.dev"},"authentication_token":{"token":"ABCD-EFAAA-ABC982374","expires_at":null}}'
  end
end