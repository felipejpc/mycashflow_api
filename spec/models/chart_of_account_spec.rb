require 'rails_helper'

RSpec.describe ChartOfAccount, type: :model do
  let(:chart_of_account) { FactoryGirl.build(:chart_of_account) }

  context 'Validations of the class' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:chart_of_account_items)}
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to respond_to(:name, :description) }
  end
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
