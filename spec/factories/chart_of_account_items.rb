FactoryGirl.define do
  factory :chart_of_account_item do
    name 'expenses'
    accounting_category 'debit'
    description { Faker::Lorem.sentence }
    ancestor_id nil
    chart_of_account
  end
end

# == Schema Information
#
# Table name: chart_of_account_items
#
# *id*::                  <tt>integer, not null, primary key</tt>
# *name*::                <tt>string</tt>
# *type*::                <tt>string</tt>
# *ancestor_id*::         <tt>integer</tt>
# *chart_of_account_id*:: <tt>integer</tt>
# *created_at*::          <tt>datetime, not null</tt>
# *updated_at*::          <tt>datetime, not null</tt>
#
# Indexes
#
#  index_chart_of_account_items_on_ancestor_id          (ancestor_id)
#  index_chart_of_account_items_on_chart_of_account_id  (chart_of_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (chart_of_account_id => chart_of_accounts.id)
#--
# == Schema Information End
#++
