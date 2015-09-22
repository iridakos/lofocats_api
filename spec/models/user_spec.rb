require 'spec_helper'

describe User do
  # Attributes

  it { should respond_to :email, :email= }
  it { should respond_to :password, :password= }
  it { should respond_to :password_confirmation, :password_confirmation= }
  it { should respond_to :password_digest, :password_digest= }
  it { should respond_to :admin, :admin=, :admin? }

  it { should respond_to :cat_entries, :cat_entries= }
  it { should respond_to :authentication_tokens, :authentication_tokens= }

  # Validations
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value('example@domain.com').for(:email) }

  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }
  it { should validate_length_of(:password).is_at_least(6) }

  it 'validates presence of password confirmation if password is set' do
    user = User.new(:password => '123')
    expect(user).to validate_presence_of(:password_confirmation)
  end
end