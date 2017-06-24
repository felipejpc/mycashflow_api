require 'rails_helper'

RSpec.describe 'Accounts API', type: :request do
    before { host! 'api.mycashflow.dev'}

  let!(:user) { FactoryGirl.create(:user) }
  let!(:account) { FactoryGirl.create(:account, user_id: user.id)}
  let(:account_id) { account.id }

  let(:headers) do 
    {
      'Accept' => 'application/mycashflow-api-version:2',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => user.auth_token
    }
  end 

  describe 'GET /accounts' do
    before do
      FactoryGirl.create_list(:account, 5, user_id: user.id)
      get '/accounts', params: { }, headers: headers 
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns 5 tasks from database' do
      expect(json_body[:accounts].count).to eq(6)
    end
  end  

  describe 'GET /accounts/:id' do
    before do
      get "/accounts/#{account_id}", params: {}, headers: headers
    end

    context 'when the account exists' do
      it 'returns the account' do
        expect(json_body[:id]).to eq(account_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the account does not exist'do
      let(:account_id) {100}
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /accounts' do
    before do
      post '/accounts', params: { account: account_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:account_params) { FactoryGirl.attributes_for(:account) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data for the created account' do
        expect(json_body[:bank_name]).to eq(account_params[:bank_name])
      end     
    end

    context 'when the request params are invalid' do
      let(:account_params) { FactoryGirl.attributes_for(:account, agency: nil) }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:agency)
      end           
    end
  end
  
  describe 'PUT /accounts/:id' do
    before do
      put "/accounts/#{account_id}", params: { account: account_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:account_params) { {bank_name: 'new_name'} }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data for the updated account' do
        expect(json_body[:bank_name]).to eq(account_params[:bank_name])
      end     
    end

    context 'when the request params are invalid' do
      let(:account_params) { { bank_name: nil } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:bank_name)
      end          
    end
  end
  
  describe 'DELETE /accounts/:id' do
    before do
      delete "/accounts/#{account_id}", params: { }, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the account from database' do
      expect(Account.find_by(id: account_id)).to be_nil 
    end     
  end
  
end