class Api::V2::BankSerializer < ActiveModel::Serializer
  attributes :id, :name, :cod
end
