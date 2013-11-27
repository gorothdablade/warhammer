FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test_#{n}@test.com"}
    first_name              "testy"
    last_name               "tester"
    nickname                "test"
    password                "123123"
    password_confirmation   "123123"
  end
end
