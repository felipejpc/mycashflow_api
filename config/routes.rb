require 'api_version_constraint'
Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v2/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(apiversion: 1) do
      resources :users, only: %i[show create update destroy]
      resources :sessions, only: %i[create destroy]
      resources :accounts, only: %i[index show create update destroy]
      resources :banks, only: %i[index show create update destroy]
    end
    
    namespace :v2, path: '/', constraints: ApiVersionConstraint.new(apiversion: 2, default: true) do
      resources :users, only: %i[show create update destroy]
      resources :sessions, only: %i[create destroy]
      resources :accounts, only: %i[index show create update destroy]
      resources :banks, only: %i[index show create update destroy]
      resources :credit_cards, only: %i[index show create update destroy]
      resources :chart_of_accounts, only: %i[index show create update destroy]
    end
  end
end

# == Route Map
#
#               Prefix Verb   URI Pattern               Controller#Action
#     new_user_session GET    /users/sign_in(.:format)  api/v2/sessions#new
#         user_session POST   /users/sign_in(.:format)  api/v2/sessions#create
# destroy_user_session DELETE /users/sign_out(.:format) api/v2/sessions#destroy
#         api_v1_users POST   /users(.:format)          api/v1/users#create {:subdomain=>"api", :format=>:json}
#          api_v1_user GET    /users/:id(.:format)      api/v1/users#show {:subdomain=>"api", :format=>:json}
#                      PATCH  /users/:id(.:format)      api/v1/users#update {:subdomain=>"api", :format=>:json}
#                      PUT    /users/:id(.:format)      api/v1/users#update {:subdomain=>"api", :format=>:json}
#                      DELETE /users/:id(.:format)      api/v1/users#destroy {:subdomain=>"api", :format=>:json}
#      api_v1_sessions POST   /sessions(.:format)       api/v1/sessions#create {:subdomain=>"api", :format=>:json}
#       api_v1_session DELETE /sessions/:id(.:format)   api/v1/sessions#destroy {:subdomain=>"api", :format=>:json}
#      api_v1_accounts GET    /accounts(.:format)       api/v1/accounts#index {:subdomain=>"api", :format=>:json}
#                      POST   /accounts(.:format)       api/v1/accounts#create {:subdomain=>"api", :format=>:json}
#       api_v1_account GET    /accounts/:id(.:format)   api/v1/accounts#show {:subdomain=>"api", :format=>:json}
#                      PATCH  /accounts/:id(.:format)   api/v1/accounts#update {:subdomain=>"api", :format=>:json}
#                      PUT    /accounts/:id(.:format)   api/v1/accounts#update {:subdomain=>"api", :format=>:json}
#                      DELETE /accounts/:id(.:format)   api/v1/accounts#destroy {:subdomain=>"api", :format=>:json}
#         api_v1_banks GET    /banks(.:format)          api/v1/banks#index {:subdomain=>"api", :format=>:json}
#                      POST   /banks(.:format)          api/v1/banks#create {:subdomain=>"api", :format=>:json}
#          api_v1_bank GET    /banks/:id(.:format)      api/v1/banks#show {:subdomain=>"api", :format=>:json}
#                      PATCH  /banks/:id(.:format)      api/v1/banks#update {:subdomain=>"api", :format=>:json}
#                      PUT    /banks/:id(.:format)      api/v1/banks#update {:subdomain=>"api", :format=>:json}
#                      DELETE /banks/:id(.:format)      api/v1/banks#destroy {:subdomain=>"api", :format=>:json}
#         api_v2_users POST   /users(.:format)          api/v2/users#create {:subdomain=>"api", :format=>:json}
#          api_v2_user GET    /users/:id(.:format)      api/v2/users#show {:subdomain=>"api", :format=>:json}
#                      PATCH  /users/:id(.:format)      api/v2/users#update {:subdomain=>"api", :format=>:json}
#                      PUT    /users/:id(.:format)      api/v2/users#update {:subdomain=>"api", :format=>:json}
#                      DELETE /users/:id(.:format)      api/v2/users#destroy {:subdomain=>"api", :format=>:json}
#      api_v2_sessions POST   /sessions(.:format)       api/v2/sessions#create {:subdomain=>"api", :format=>:json}
#       api_v2_session DELETE /sessions/:id(.:format)   api/v2/sessions#destroy {:subdomain=>"api", :format=>:json}
#      api_v2_accounts GET    /accounts(.:format)       api/v2/accounts#index {:subdomain=>"api", :format=>:json}
#                      POST   /accounts(.:format)       api/v2/accounts#create {:subdomain=>"api", :format=>:json}
#       api_v2_account GET    /accounts/:id(.:format)   api/v2/accounts#show {:subdomain=>"api", :format=>:json}
#                      PATCH  /accounts/:id(.:format)   api/v2/accounts#update {:subdomain=>"api", :format=>:json}
#                      PUT    /accounts/:id(.:format)   api/v2/accounts#update {:subdomain=>"api", :format=>:json}
#                      DELETE /accounts/:id(.:format)   api/v2/accounts#destroy {:subdomain=>"api", :format=>:json}
#         api_v2_banks GET    /banks(.:format)          api/v2/banks#index {:subdomain=>"api", :format=>:json}
#                      POST   /banks(.:format)          api/v2/banks#create {:subdomain=>"api", :format=>:json}
#          api_v2_bank GET    /banks/:id(.:format)      api/v2/banks#show {:subdomain=>"api", :format=>:json}
#                      PATCH  /banks/:id(.:format)      api/v2/banks#update {:subdomain=>"api", :format=>:json}
#                      PUT    /banks/:id(.:format)      api/v2/banks#update {:subdomain=>"api", :format=>:json}
#                      DELETE /banks/:id(.:format)      api/v2/banks#destroy {:subdomain=>"api", :format=>:json}
# 
