FactoryGirl.define do
  factory :authentication_token do
    user { FactoryGirl.build(:user) }
    token { 'ABCD-EFAAA-ABC982374' }
  end
end