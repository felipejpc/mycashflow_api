FactoryGirl.define do
  factory :bank do
    name { Faker::Bank.name }
    cod { Faker::Bank.swift_bic }
  end
end
