require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  context 'Validations of class' do
    it { is_expected.to have_many(:accounts).dependent(:destroy) }
    it { is_expected.to have_many(:credit_cards).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:short_name) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value('felipe@gmail.com').for(:email) }
    it { is_expected.to validate_uniqueness_of(:auth_token) }
  end

  describe '#info' do
    it 'returns email and created_at' do
      expect(user.info).to eq("#{user.email} - #{user.created_at}")
    end
  end

  describe '#generate_authentication_token!' do
    it 'generates a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('123qweasdzxc')
      user.generate_authentication_token!

      expect(user.auth_token).to eq('123qweasdzxc')
    end

    it 'generates another token with the current token already has been taken' do
      allow(Devise).to receive(:friendly_token).and_return('123qweasdzxc', '123qweasdzxc', '123qweasd321')
      existing_user = create(:user)
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end
end

# == Schema Information
#
# Table name: users
#
# *id*::                     <tt>integer, not null, primary key</tt>
# *email*::                  <tt>string, default(""), not null</tt>
# *encrypted_password*::     <tt>string, default(""), not null</tt>
# *reset_password_token*::   <tt>string</tt>
# *reset_password_sent_at*:: <tt>datetime</tt>
# *remember_created_at*::    <tt>datetime</tt>
# *sign_in_count*::          <tt>integer, default(0), not null</tt>
# *current_sign_in_at*::     <tt>datetime</tt>
# *last_sign_in_at*::        <tt>datetime</tt>
# *current_sign_in_ip*::     <tt>inet</tt>
# *last_sign_in_ip*::        <tt>inet</tt>
# *confirmation_token*::     <tt>string</tt>
# *confirmed_at*::           <tt>datetime</tt>
# *confirmation_sent_at*::   <tt>datetime</tt>
# *unconfirmed_email*::      <tt>string</tt>
# *failed_attempts*::        <tt>integer, default(0), not null</tt>
# *unlock_token*::           <tt>string</tt>
# *locked_at*::              <tt>datetime</tt>
# *created_at*::             <tt>datetime, not null</tt>
# *updated_at*::             <tt>datetime, not null</tt>
# *auth_token*::             <tt>string</tt>
#
# Indexes
#
#  index_users_on_auth_token            (auth_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#--
# == Schema Information End
#++
