FactoryGirl.define do
  factory :bank do
    name { Faker::Bank.name }
    cod { Faker::Number.number(5) }
  end
end
