class User < ActiveRecord::Base
  ### Relations ###

  # Enable Rails' functionality for password management
  has_secure_password

  has_many :authentication_tokens, :inverse_of => :user, :dependent => :destroy
  has_many :cat_entries, :inverse_of => :user, :dependent => :destroy

  ### Validations ###
  validates :email, :presence => true, :uniqueness => true, :email => true
  validates :password, :length => { :minimum => 6, :if => 'password.present?' }
  validates :password_confirmation, :presence =>  { :if => 'password.present?'}

  # Generates a new token for the user. Explicit user save has to be executed to be saved.
  def generate_new_token!
    authentication_tokens.build(:token => SecureRandom.uuid)
  end
end
