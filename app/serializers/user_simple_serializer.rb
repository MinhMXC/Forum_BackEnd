class UserSimpleSerializer < ActiveModel::Serializer
  attributes :id, :username, :image
end