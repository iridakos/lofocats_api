require 'spec_helper'

describe AuthenticationToken do
  subject { FactoryGirl.create(:authentication_token) }

  ### Attributes ###

  it { should respond_to :user, :user= }
  it { should respond_to :token, :token= }
  it { should respond_to :expires_at, :expires_at= }

  ### Validations ###

  it { should be_valid }
  it { should validate_presence_of :user }
  it { should validate_presence_of :token }
  it { should validate_uniqueness_of :token }

  ### Hooks ###
  it 'should auto-set expiration' do
    Timecop.freeze(Time.local(2015)) do
      expect(FactoryGirl.create(:authentication_token).expires_at).to eq (DateTime.now + 3.days)
    end
  end
end