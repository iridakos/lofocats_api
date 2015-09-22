require 'spec_helper'

describe AuthenticationTokenSerializer do
  let(:authentication_token) { FactoryGirl.build(:authentication_token) }

  subject { AuthenticationTokenSerializer.new(authentication_token).to_json }

  it 'should serialize the correct attributes' do
    expect(subject).to eq '{"token":"ABCD-EFAAA-ABC982374","expires_at":null}'
  end
end