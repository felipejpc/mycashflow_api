class Api::V2::AccountSerializer < ActiveModel::Serializer
  attributes :id, :bank_name, :account, :agency
  belongs_to :user
  belongs_to :bank
end
