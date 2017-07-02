FactoryGirl.define do
  factory :account do
    bank_name { Faker::Bank.name }
    account '3452'
    agency '23'
    user
    bank { Faker::Number.number(3) }
  end
end

# == Schema Information
#
# Table name: accounts
#
# *id*::         <tt>integer, not null, primary key</tt>
# *bank_name*::  <tt>string</tt>
# *account*::    <tt>string</tt>
# *agency*::     <tt>string</tt>
# *user_id*::    <tt>integer</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
# *bank_id*::    <tt>integer</tt>
#
# Indexes
#
#  index_accounts_on_bank_id  (bank_id)
#  index_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (bank_id => banks.id)
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
