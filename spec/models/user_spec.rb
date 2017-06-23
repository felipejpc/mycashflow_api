require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  context "Validations of class" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value("felipe@gmail.com").for(:email) }
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
