##
# This class implement a Chart of Accounts Model
class ChartOfAccount < ApplicationRecord
  belongs_to :user
  has_many :chart_of_account_items

  validates_presence_of :name
end

# == Schema Information
#
# Table name: chart_of_accounts
#
# *id*::          <tt>integer, not null, primary key</tt>
# *name*::        <tt>string</tt>
# *description*:: <tt>text</tt>
# *user_id*::     <tt>integer</tt>
# *created_at*::  <tt>datetime, not null</tt>
# *updated_at*::  <tt>datetime, not null</tt>
#
# Indexes
#
#  index_chart_of_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#--
# == Schema Information End
#++
