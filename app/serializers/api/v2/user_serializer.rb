class Api::V2::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token
end
