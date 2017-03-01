FactoryGirl.define do
  factory :pizza do
    name { Faker::Lorem.word }
    order_id nil
  end
end
