class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :image, :bio, :created_at, :updated_at
  has_many :posts
  has_many :comments
end
