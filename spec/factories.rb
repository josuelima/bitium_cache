FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
  end

  factory :app do
    application Faker::Name.name
    resource Faker::Internet.url
  end
end
