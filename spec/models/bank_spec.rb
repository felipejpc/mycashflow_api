require 'rails_helper'

RSpec.describe Bank, type: :model do
  let(:bank) { FactoryGirl.build(:bank) }

  context 'Validations of class' do
    it { is_expected.to have_many(:accounts).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:cod) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:cod).case_insensitive }

  it { is_expected.to respond_to(:name, :cod) }
  end

  describe '#info' do
    it 'returns bank info (cod + name)' do
      expect(bank.info).to eq("#{bank.cod} - #{bank.name}")
    end
  end

end
