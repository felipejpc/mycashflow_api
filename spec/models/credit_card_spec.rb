require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  let(:credit_card) { FactoryGirl.build(:credit_card) }

  context 'Validations of the class' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_uniqueness_of(:number) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:number) }

    it { is_expected.to respond_to(:name, :number, :description) }
  end

  describe '#info' do
    it 'return credit card info' do
      expect(credit_card.info).to eq("#{credit_card.name} nº #{credit_card.number}")
    end
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
