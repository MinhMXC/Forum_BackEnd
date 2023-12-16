class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :like_count, :dislike_count, :image, :user_id, :created_at, :updated_at
  has_many :comments
  has_many :tags
end
