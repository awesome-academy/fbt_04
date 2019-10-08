# spec/factories/reviews.rb
require "faker"

FactoryGirl.define do
  factory :review do |f|
    f.tour_id {Tour.first}
    f.user_id {User.first}
    f.content {Faker::Name.name}
  end
end
