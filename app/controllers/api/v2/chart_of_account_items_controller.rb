class Api::V2::ChartOfAccountItemsController < ApplicationController
    before_action :authenticate_with_token!

  def index
    chart_of_account_items = current_user.chart_of_accounts.find(params[:chart_of_account_id]).chart_of_account_items
    render json: chart_of_account_items, status: 200
  end

  def show
    chart_of_account_item = current_user.chart_of_accounts.find(params[:chart_of_account_id]).chart_of_account_items.find(params[:id])
    render json: chart_of_account_item, status: 200
  rescue
    head 404
  end

  def create
    chart_of_account_item = current_user.chart_of_accounts.find(params[:chart_of_account_id]).chart_of_account_items.build(chart_of_account_item_params)
    if chart_of_account_item.save
      render json: chart_of_account_item, status: 201
    else
      render json: { errors: chart_of_account_item.errors }, status: 422
    end
  end

  def update
    chart_of_account_item = current_user.chart_of_accounts.find(params[:chart_of_account_id]).chart_of_account_items.find(params[:id])
    if chart_of_account_item.update(chart_of_account_item_params)
      render json: chart_of_account_item, status: 200
    else
      render json: { errors: chart_of_account_item.errors }, status: 422
    end
  end

  def destroy
    current_user.chart_of_accounts.find(params[:chart_of_account_id]).chart_of_account_items.find(params[:id]).destroy
    head 204
  end

  private

  def chart_of_account_item_params
    params.require(:chart_of_account_item).permit(:description, :name, :accounting_category, :chart_of_account_id, :ancestor_id)
  end
end
