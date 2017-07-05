require 'rails_helper'

RSpec.describe 'ChartOfAccounts API', type: :request do
  before { host! 'api.mycashflow.dev' }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:chart_of_account) { FactoryGirl.create(:chart_of_account, user_id: user.id) }
  let!(:chart_of_account_id) { chart_of_account.id }

  let!(:headers) do
    {
      'Accept' => 'application/mycashflow-api-version:2',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => user.auth_token
    }
  end

  describe 'GET /chart_of_accounts' do
    before do
      FactoryGirl.create_list(:chart_of_account, 5, user_id: user.id)
      get '/chart_of_accounts', params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns 6 tasks from database' do
      expect(json_body[:data].count).to eq(6)
    end
  end
    
  describe 'GET /chart_of_accounts/:id' do
    before do
      get "/chart_of_accounts/#{chart_of_account_id}", params: {}, headers: headers
    end

    context 'when the account exists' do
      it 'returns the account' do
        expect(json_body[:data][:id]).to eq(chart_of_account_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the account does not exist' do
      let(:chart_of_account_id) { 100 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /chart_of_accounts' do
    before do
      post '/chart_of_accounts', params: { chart_of_account: chart_of_account_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:chart_of_account_params) { FactoryGirl.attributes_for(:chart_of_account, user_id: user.id) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data for the created account' do
        expect(json_body[:data][:attributes][:'name']).to eq(chart_of_account_params[:name])
      end
    end

    context 'when the request params are invalid' do
      let(:chart_of_account_params) { FactoryGirl.attributes_for(:chart_of_account, name: nil) }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'PUT /chart_of_accounts/:id' do
    before do
      put "/chart_of_accounts/#{chart_of_account_id}", params: { chart_of_account: chart_of_account_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:chart_of_account_params) { { name: 'New Chart of Account Name' } }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data for the updated account' do
        expect(json_body[:data][:attributes][:name]).to eq(chart_of_account_params[:name])
      end
    end

    context 'when the request params are invalid' do
      let(:chart_of_account_params) { { name: nil } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'DELETE /chart_of_accounts/:id' do
    before do
      delete "/chart_of_accounts/#{chart_of_account_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the account from database' do
      expect(ChartOfAccount.find_by(id: chart_of_account_id)).to be_nil
    end
  end
end
