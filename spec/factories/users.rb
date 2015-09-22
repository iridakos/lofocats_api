FactoryGirl.define do
  factory :user do
    email 'test@lofocat.dev'
    password '12345678'
    password_confirmation '12345678'
  end

  factory :admin_user, :class => User do
    email 'admin@lofocat.dev'
    password '12345678'
    password_confirmation '12345678'
    admin true
  end
end