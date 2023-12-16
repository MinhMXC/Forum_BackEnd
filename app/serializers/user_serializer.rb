class UserSerializer < ActiveModel::Serializer
  attributes :username, :image, :bio
  has_many :posts
  has_many :comments
end
