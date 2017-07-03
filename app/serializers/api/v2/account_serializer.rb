class Api::V2::AccountSerializer < ActiveModel::Serializer
  attributes :id, :description, :account, :agency
  belongs_to :user
  belongs_to :bank
end
