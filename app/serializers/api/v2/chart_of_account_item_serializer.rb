class Api::V2::ChartOfAccountItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :accounting_category, :ancestor_id
  belongs_to :chart_of_account
end