require 'rails_helper'

RSpec.describe ChartOfAccountItem, type: :model do
  let(:chart_of_account_item) { FactoryGirl.build(:chart_of_account_item) }

  context 'Validations of the class' do
    it { is_expected.to belong_to(:chart_of_account) }
    it { is_expected.to belong_to(:ancestor) }
    it { is_expected.to have_many(:subsequents) }
    
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:accounting_category) }
    it { is_expected.to validate_inclusion_of(:accounting_category).in_array(['debit', 'credit']) }
    
    it { is_expected.to respond_to(:name, :accounting_category, :description) }
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
