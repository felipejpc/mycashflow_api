require 'rails_helper'

RSpec.describe 'ChartOfAccountItems API', type: :request do
  before { host! 'api.mycashflow.dev' }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:chart_of_account) { FactoryGirl.create(:chart_of_account, user_id: user.id) }
  let!(:chart_of_account_id) { chart_of_account.id }
  let!(:chart_of_account_item) { FactoryGirl.create(:chart_of_account_item, chart_of_account_id: chart_of_account.id) }
  let!(:chart_of_account_item_id) { chart_of_account_item.id }


  let!(:headers) do
    {
      'Accept' => 'application/mycashflow-api-version:2',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => user.auth_token
    }
  end

  describe 'GET /chart_of_accounts/:id/chart_of_account_items' do
    before do
      FactoryGirl.create_list(:chart_of_account_item, 5, chart_of_account_id: chart_of_account.id)
      get "/chart_of_accounts/#{chart_of_account_id}/chart_of_account_items", params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns 6 registers from database' do
      expect(json_body[:data].count).to eq(6)
    end
  end
    
  describe 'GET /chart_of_accounts/:id/chart_of_account_items/:id' do
    before do
      get "/chart_of_accounts/#{chart_of_account_id}/chart_of_account_items/#{chart_of_account_item_id}", params: {}, headers: headers
    end

    context 'when the account exists' do
      it 'returns the account' do
        expect(json_body[:data][:id]).to eq(chart_of_account_item_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the register does not exist' do
      let(:chart_of_account_item_id) { 100 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /chart_of_account/:id/chart_of_account_items' do
    before do
      post "/chart_of_accounts/#{chart_of_account_id}/chart_of_account_items", params: { chart_of_account_item: chart_of_account_item_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:chart_of_account_item_params) { FactoryGirl.attributes_for(:chart_of_account_item, chart_of_account_id: chart_of_account.id) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data for the created account' do
        expect(json_body[:data][:attributes][:'name']).to eq(chart_of_account_item_params[:name])
      end
    end

    context 'when the request params are invalid' do
      let(:chart_of_account_item_params) { FactoryGirl.attributes_for(:chart_of_account_item, name: nil) }
  
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'PUT /chart_of_accounts/:id/chart_of_account_items/:id' do
    before do
      put "/chart_of_accounts/#{chart_of_account_id}/chart_of_account_items/#{chart_of_account_item_id}", params: { chart_of_account_item: chart_of_account_item_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:chart_of_account_item_params) { { name: 'New Name' } }
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data for the updated register' do
        expect(json_body[:data][:attributes][:name]).to eq(chart_of_account_item_params[:name])
      end
    end

    context 'when the request params are invalid' do
      let(:chart_of_account_item_params) { { name: nil } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json for the errors' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'DELETE /chart_of_accounts/:id/chart_of_account_items/:id' do
    before do
      delete "/chart_of_accounts/#{chart_of_account_id}/chart_of_account_items/#{chart_of_account_item_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the account from database' do
      expect(ChartOfAccountItem.find_by(id: chart_of_account_item_id)).to be_nil
    end
  end
end
