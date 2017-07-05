class Api::V2::ChartOfAccountsController < ApplicationController
  before_action :authenticate_with_token!

  def index
    chart_of_accounts = current_user.chart_of_accounts
    render json: chart_of_accounts, status: 200
  end

  def show
    chart_of_account = current_user.chart_of_accounts.find(params[:id])
    render json: chart_of_account, status: 200
  rescue
    head 404
  end

  def create
    chart_of_account = current_user.chart_of_accounts.build(chart_of_account_params)
    if chart_of_account.save
      render json: chart_of_account, status: 201
    else
      render json: { errors: chart_of_account.errors }, status: 422
    end
  end

  def update
    chart_of_account = current_user.chart_of_accounts.find(params[:id])
    if chart_of_account.update(chart_of_account_params)
      render json: chart_of_account, status: 200
    else
      render json: { errors: chart_of_account.errors }, status: 422
    end
  end

  def destroy
    current_user.chart_of_accounts.find(params[:id]).destroy
    head 204
  end

  private

  def chart_of_account_params
    params.require(:chart_of_account).permit(:description, :name, :user_id)
  end
end
