require 'spec_helper'

describe CatEntrySerializer do
  let(:cat_entry) { FactoryGirl.create(:cat_entry, :user => FactoryGirl.create(:user)) }

  subject { CatEntrySerializer.new(cat_entry).to_json }

  it 'should serialize the correct attributes' do
    expect(subject).to eq '{"id":1,"breed":"Persian","color":"Grey","longitude":"13.222444","latitude":"34.234123","contact_phone":"0031123456789","contact_email":"found_a_cat@lofocats.com","event_date":"2015-09-26","entry_type":"lost","resolved":null,"chip":null,"photo_url":"http://lofocats.com/an_image.png","user":{"id":1,"email":"test@lofocat.dev","admin":null}}'
  end
end
