class Api::V2::ChartOfAccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  belongs_to :user
end