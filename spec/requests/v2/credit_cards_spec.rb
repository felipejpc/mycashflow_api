require 'rails_helper'

RSpec.describe 'CreditCard API', type: :request do
  before { host! 'api.mycashflow.dev' }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:credit_card) { FactoryGirl.create(:credit_card, user_id: user.id) }
  let!(:credit_card_id) { credit_card.id }

  let!(:headers) do
    {
      'Accept' => 'application/mycashflow-api-version:2',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => user.auth_token
    }
  end

  describe 'GET /credit_cards' do
    context 'when the filter param is not sent' do
      before do
        FactoryGirl.create_list(:credit_card, 5, user_id: user.id)
        get '/credit_cards', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 6 registers from database' do
        expect(json_body[:data].count).to eq(6)
      end
    end

    context 'when the filter param is sent' do
      let!(:register_1) { FactoryGirl.create(:credit_card, name: 'cartao do banco do brasil', 
      number: '12345678901231', user_id: user.id) }
      let!(:register_2) { FactoryGirl.create(:credit_card, name: 'cartao da caixa economica', 
      number: '12345678901232', user_id: user.id) }
      let!(:register_3) { FactoryGirl.create(:credit_card, name: 'cartao da brasilcred', 
      number: '12345678901233', user_id: user.id) }       
      
      before do     
        get '/credit_cards?q[name_cont]=bras&q[s]=name+DESC', params: {}, headers: headers
      end

      it 'returns only the matching results in the correct order' do
        retuned_results = json_body[:data].map { |t| t[:attributes][:'name']}

        expect(retuned_results).to eq([ register_1.name, register_3.name ])
      end
    end
  end
    
  describe 'GET /credit_cards/:id' do
    before do
      get "/credit_cards/#{credit_card_id}", params: {}, headers: headers
    end

    context 'when the account exists' do
      it 'returns the account' do
        expect(json_body[:data][:id]).to eq(credit_card_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the account does not exist' do
      let(:credit_card_id) { 100 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /credit_cards' do
    before do
      post '/credit_cards', params: { credit_card: credit_card_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:credit_card_params) { FactoryGirl.attributes_for(:credit_card, user_id: user.id) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data for the created account' do
        expect(json_body[:data][:attributes][:'name']).to eq(credit_card_params[:name])
      end
    end

    context 'when the request params are invalid' do
      let(:credit_card_params) { FactoryGirl.attributes_for(:credit_card, name: nil) }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'PUT /credit_cards/:id' do
    before do
      put "/credit_cards/#{credit_card_id}", params: { credit_card: credit_card_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:credit_card_params) { { name: 'Credit Card Name' } }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data for the updated account' do
        expect(json_body[:data][:attributes][:name]).to eq(credit_card_params[:name])
      end
    end

    context 'when the request params are invalid' do
      let(:credit_card_params) { { name: nil } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'DELETE /credit_cards/:id' do
    before do
      delete "/credit_cards/#{credit_card_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the account from database' do
      expect(CreditCard.find_by(id: credit_card_id)).to be_nil
    end
  end
end
