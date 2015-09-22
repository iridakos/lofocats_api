class CatEntrySerializer < ActiveModel::Serializer
  # Serialized attirbutes for the Cat entry
  attributes :id, :breed, :color, :longitude, :latitude, :contact_phone, :contact_email, :event_date, :entry_type, :resolved, :chip, :photo_url

  # Include user as well
  has_one :user
end
