FactoryGirl.define do
  factory :credit_card do
    name "Cartão Visa Platinum Internacional"
    description { Faker::Lorem.sentence }
    number { Faker::Number.number(16) }
    user
  end
end

# == Schema Information
#
# Table name: credit_cards
#
# *id*::          <tt>integer, not null, primary key</tt>
# *name*::        <tt>string</tt>
# *description*:: <tt>text</tt>
# *number*::      <tt>string</tt>
# *user_id*::     <tt>integer</tt>
# *created_at*::  <tt>datetime, not null</tt>
# *updated_at*::  <tt>datetime, not null</tt>
#
# Indexes
#
#  index_credit_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
