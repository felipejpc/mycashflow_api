require 'rails_helper'

RSpec.describe 'Banks API', type: :request do
  before { host! 'api.mycashflow.dev' }

  let!(:bank) { FactoryGirl.create(:bank) }
  let(:bank_id) { bank.id }
  let(:headers) do
    {
      'Accept' => 'application/mycashflow-api-version:2',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => ''
    }
  end

  describe 'GET /banks' do
    context 'when the filter param is not sent' do
      before do
        FactoryGirl.create_list(:bank, 5)
        get '/banks', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 6 registers from database' do
        expect(json_body[:data].count).to eq(6)
      end
    end

    context 'when the filter param is sent' do
      let!(:register_1) { FactoryGirl.create(:bank, name: 'banco do brasil', 
      cod: '001') }
      let!(:register_2) { FactoryGirl.create(:bank, name: 'caixa economica', 
      cod: '304') }
      let!(:register_3) { FactoryGirl.create(:bank, name: 'banco bradesco', 
      cod: '234') }      
      
      before do     
        get '/banks?q[name_cont]=bra&q[s]=cod+DESC', params: {}, headers: headers
      end

      it 'returns only the matching results in the correct order' do
        retuned_results = json_body[:data].map { |t| t[:attributes][:'name']}

        expect(retuned_results).to eq([ register_3.name, register_1.name ])
      end
    end
  end

  describe 'GET /banks/:id' do
    before do
      get "/banks/#{bank_id}", params: {}, headers: headers
    end

    context 'when the bank exists' do
      it 'returns the user' do
        expect(json_body[:data][:id]).to eq(bank_id.to_s)
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

      it 'returns json data for the created bank' do
        expect(json_body[:data][:attributes][:name]).to eq(bank_params[:name])
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
        expect(json_body[:data][:attributes][:name]).to eq(bank_params[:name])
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
      expect(Bank.find_by(id: bank_id)).to be_nil
    end
  end
end