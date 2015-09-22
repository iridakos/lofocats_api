class AuthenticationToken < ActiveRecord::Base
  ### Relations ###

  # The user for this authentication token
  belongs_to :user, :inverse_of => :authentication_tokens

  ### Hooks ###

  # Set expiration upon save
  before_save :set_expiration

  ### Validations ###
  validates :user, :presence => true
  validates :token, :presence => true, :uniqueness => true

  ### Scopes ###

  # Default scope excludes expired tokens
  default_scope -> { where('expires_at > :now', :now => DateTime.now) }
  scope :expired, -> { unscoped.where('expires_at <= :now', :now => DateTime.now) }

  private

  # Sets the default expiration of the token
  def set_expiration
    # TODO: load the expiration period (now fixed to 3) from a configuration file
    self.expires_at ||= DateTime.now + 3.days
  end
end
