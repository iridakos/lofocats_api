require 'spec_helper'

describe CatEntry do
  subject { FactoryGirl.build(:cat_entry) }

  it { should respond_to :user, :user= }
  it { should respond_to :breed, :breed= }
  it { should respond_to :color, :color= }
  it { should respond_to :longitude, :longitude= }
  it { should respond_to :latitude, :latitude= }
  it { should respond_to :contact_phone, :contact_phone= }
  it { should respond_to :contact_email, :contact_email= }
  it { should respond_to :event_date, :event_date= }
  it { should respond_to :entry_type, :entry_type=}
  it { should respond_to :resolved, :resolved=, :resolved? }
  it { should respond_to :chip, :chip= }
  it { should respond_to :photo_url, :photo_url= }

  it { should validate_presence_of :user }
  it { should validate_presence_of :breed }
  it { should validate_length_of(:breed).is_at_most(128) }
  it { should validate_presence_of :color }
  it { should validate_length_of(:color).is_at_most(48) }
  it { should validate_presence_of :longitude }
  it { should validate_length_of(:longitude).is_at_most(16) }
  it { should validate_presence_of :latitude }
  it { should validate_length_of(:latitude).is_at_most(16) }
  it { should validate_presence_of :contact_phone }
  it { should validate_length_of(:contact_phone).is_at_most(16) }
  it { should validate_presence_of :contact_email }
  it { should validate_presence_of :event_date }
  it { should validate_inclusion_of(:entry_type).in_array(%w(lost found)) }

  context 'email validation' do
    it 'should not allow invalid contact email' do
      subject.contact_email = 'foo'

      expect(subject.valid?).to be_falsey
      expect(subject.errors[:contact_email]).to include('is not an email')
    end

    it 'should allow valid contact emails' do
      subject.contact_email = 'lazarus@lofocats.com'

      expect(subject).to be_valid
    end
  end

  context 'photo url validation' do
    it 'should not allow invalid urls' do
      subject.photo_url = 'invalid.url'

      expect(subject.valid?).to be_falsey
      expect(subject.errors[:photo_url]).to include('is invalid')
    end

    it 'should allow valid urls' do
      subject.photo_url = 'http://lofocats.com/foo.png'

      expect(subject.valid?).to be_truthy
    end
  end
end