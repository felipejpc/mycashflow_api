FactoryGirl.define do
  factory :bank do
    name { Faker::Bank.name }
    cod { Faker::Number.number(5) }
  end
end

# == Schema Information
#
# Table name: banks
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string</tt>
# *cod*::        <tt>string</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#--
# == Schema Information End
#++
