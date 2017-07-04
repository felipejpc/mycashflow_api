class Api::V2::CreditCardsController < ApplicationController
  before_action :authenticate_with_token!

  def index
    credit_cards = current_user.credit_cards.ransack(params[:q]).result
    render json: credit_cards, status: 200
  end

  def show
    credit_card = current_user.credit_cards.find(params[:id])
    render json: credit_card, status: 200
  rescue
    head 404
  end

  def create
    credit_card = current_user.credit_cards.build(credit_card_params)
    if credit_card.save
      render json: credit_card, status: 201
    else
      render json: { errors: credit_card.errors }, status: 422
    end
  end

  def update
    credit_card = current_user.credit_cards.find(params[:id])
    if credit_card.update(credit_card_params)
      render json: credit_card, status: 200
    else
      render json: { errors: credit_card.errors }, status: 422
    end
  end

  def destroy
    current_user.credit_cards.find(params[:id]).destroy
    head 204
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:description, :name, :number, :user_id)
  end
end
