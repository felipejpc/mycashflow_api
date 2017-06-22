require 'rails_helper'

RSpec.describe 'Banks API', type: :request do
  let!(:bank) { FactoryGirl.create(:bank) }
  let(:bank_id) { bank.id }

  describe 'GET /banks/:id' do
    before do
      headers = { 'Accept' => 'application/mycashflow-api-version:1' }
      get "/banks/#{bank_id}", params: {}, headers: headers
    end

    context 'when the user exists' do
      it 'returns the user' do
        bank_response = JSON.parse(response.body)
        expect(bank_response['id']).to eq(bank_id)
      end
    end
  end

end