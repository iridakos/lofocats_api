require 'spec_helper'

describe UserSessionSerializer do
  let(:user) { FactoryGirl.build(:user, :id => 1) }
  let(:authentication_token) { FactoryGirl.build(:authentication_token, :user => user) }
  let(:session_information) { {:user => user, :authentication_token => authentication_token} }

  subject { UserSessionSerializer.new(session_information).to_json }

  it 'should serialize the correct attributes' do
    expect(subject).to eq '{"user":{"id":1,"email":"test@lofocat.dev","admin":null},"authentication_token":{"token":"ABCD-EFAAA-ABC982374","expires_at":null}}'
  end
end
