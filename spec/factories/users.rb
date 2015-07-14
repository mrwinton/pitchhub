FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password 'password123'
    first_name 'Tester'
    last_name 'McTest'
  end
end
