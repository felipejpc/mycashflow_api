class Api::V2::AccountsController < ApplicationController
  before_action :authenticate_with_token!

  def index
    accounts = current_user.accounts
    render json: accounts, status: 200
  end

  def show
    begin
      account = current_user.accounts.find(params[:id])
      render json: account, status: 200
    rescue
      head 404      
    end
  end

  def create
    account = current_user.accounts.build(account_params)
    if account.save
      render json: account, status: 201
    else      
      render json: { errors: account.errors}, status: 422      
    end
  end

  def update
    account = current_user.accounts.find(params[:id])
    if account.update(account_params)
      render json: account, status: 200
    else
      render json: {errors: account.errors}, status: 422
    end        
  end

  def destroy
    current_user.accounts.find(params[:id]).destroy
    head 204
  end

  private

  def account_params
    params.require(:account).permit(:bank_name, :account, :agency)  
  end


end
