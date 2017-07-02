##
# This class representing a MyCashFlow User's Account. 
# In this class you'll find all Account method's.
class Account < ApplicationRecord

##
# Account relations
  belongs_to :user
  belongs_to :bank

  validates_presence_of :bank_name, :account, :agency
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
