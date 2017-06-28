##
# This Class controls the basic CRUD method's of bank's
class Api::V2::BanksController < ApplicationController
  def index
    banks = Bank.all.ransack(params[:q]).result
    render json: banks, status: 200
  end

  def show
    bank = Bank.find(params[:id])
    render json: bank, status: 200
  rescue
    head 404
  end

  def create
    bank = Bank.new(bank_params)
    if bank.save
      render json: bank, status: 201
    else
      render json: { errors: bank.errors }, status: 422
    end
  end

  def update
    bank = Bank.find(params[:id])
    if bank.update(bank_params)
      render json: bank, status: 200
    else
      render json: { errors: bank.errors }, status: 422
    end
  end

  def destroy
    Bank.find(params[:id]).destroy
    head 204
  end

  private

  def bank_params
    params.require(:bank).permit(:name, :cod)
  end
end
