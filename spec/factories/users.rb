FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password '12345678'
    password_confirmation '12345678'

    factory :facebook_user do
      provider 'facebook'
      uid { Faker::Number.number(7) }
    end
  end

end
