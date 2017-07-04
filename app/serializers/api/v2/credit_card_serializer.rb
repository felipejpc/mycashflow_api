class Api::V2::CreditCardSerializer < ActiveModel::Serializer
  attributes :id, :description, :name, :number
  belongs_to :user
end
