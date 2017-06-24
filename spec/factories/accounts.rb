FactoryGirl.define do
  factory :account do
    bank_name { Faker::Bank.name }
    account '3452'
    agency '23'
    user
  end
end
