class CatEntry < ActiveRecord::Base
  ### Relations ###
  belongs_to :user, :inverse_of => :cat_entries

  ### Validations ###
  validates :user, :presence => true
  validates :breed, :presence => true, :length => { :maximum => 128 }
  validates :color, :presence => true, :length => { :maximum => 48 }
  validates :longitude, :presence => true, :length => { :maximum => 16 }
  validates :latitude, :presence => true, :length => { :maximum => 16 }
  validates :contact_phone, :presence => true, :length => { :maximum => 16 }
  validates :contact_email, :presence => true, :email => true
  validates :event_date, :presence => true
  validates :entry_type, :inclusion => { :in => %w(lost found) }
  validates :photo_url, :format => { :with => URI::regexp(%w(http https)) }

  ### Scopes ###

  # Default scope excludes resolved entries
  default_scope -> { where(:resolved => [false, nil]) }

  scope :found, -> { where(:entry_type => :found) }
  scope :lost, -> { where(:entry_type => :lost) }
  scope :resolved, -> { unscoped.where(:resolved => true) }
end
