FactoryGirl.define do
  factory :cat_entry do
    user { FactoryGirl.build(:user) }
    breed 'Persian'
    color 'Grey'
    longitude 13.222444
    latitude 34.234123
    contact_phone '0031123456789'
    contact_email 'found_a_cat@lofocats.com'
    event_date { Date.new(2015,9,26) }
    entry_type 'lost'
    photo_url 'http://lofocats.com/an_image.png'

    factory :new_cat_entry, :class => CatEntry do
      user nil
    end
  end
end
