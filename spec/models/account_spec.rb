require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { FactoryGirl.build(:task) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of :bank_name }
  it { is_expected.to validate_presence_of :account }
  it { is_expected.to validate_presence_of :agency }

  it { is_expected.to respond_to(:bank_name, :account, :agency) }
end
