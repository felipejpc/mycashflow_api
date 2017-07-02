require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { FactoryGirl.build(:task) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:bank) }

  it { is_expected.to validate_presence_of :bank_name }
  it { is_expected.to validate_presence_of :account }
  it { is_expected.to validate_presence_of :agency }

  it { is_expected.to respond_to(:bank_name, :account, :agency) }
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
