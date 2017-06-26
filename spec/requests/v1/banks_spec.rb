require 'rails_helper'

RSpec.describe 'Banks API', type: :request do
  before { host! 'api.mycashflow.dev' }

  let!(:bank) { FactoryGirl.create(:bank) }
  let(:bank_id) { bank.id }
  let(:headers) do
    {
      'Accept' => 'application/mycashflow-api-version:1',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => ''
    }
  end

  describe 'GET /banks' do
    before do
      FactoryGirl.create_list(:bank, 5)
      get '/banks', params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns 6 registers from database' do
      expect(json_body[:banks].count).to eq(6)
    end
  end

  describe 'GET /banks/:id' do
    before do
      get "/banks/#{bank_id}", params: {}, headers: headers
    end

    context 'when the bank exists' do
      it 'returns the bank' do
        expect(json_body[:id]).to eq(bank_id)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the bank does not exist' do
      let(:bank_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /banks' do
    before do
      post '/banks', params: { bank: bank_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:bank_params) { FactoryGirl.attributes_for(:bank) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data for the created account' do
        expect(json_body[:name]).to eq(bank_params[:name])
      end
    end

    context 'when the request params are invalid' do
      let(:bank_params) { FactoryGirl.attributes_for(:bank, name: nil) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'PUT /banks/:id' do
    before do
      put "/banks/#{bank_id}", params: { bank: bank_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:bank_params) { { name: 'new_name' } }
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data for the updated bank' do
        expect(json_body[:name]).to eq(bank_params[:name])
      end
    end

    context 'when the request params are invalid' do
      let(:bank_params) { { name: nil } }
      
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'DELETE /banks/:id' do
    before do
      delete "/banks/#{bank_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the bank from database' do
      expect(Account.find_by(id: bank_id)).to be_nil
    end
  end
end
