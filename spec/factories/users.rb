# spec/factories/users.rb
require "faker"

FactoryGirl.define do
  factory :user do |f|
    f.fullname {Faker::Name.name}
    f.email {Faker::Internet.email}
    f.password {Faker::Internet.password}
  end
end
