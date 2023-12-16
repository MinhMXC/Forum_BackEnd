class CommentSerializer < ActiveModel::Serializer
  attributes :body, :like_count, :dislike_count, :user_id, :created_at, :updated_at
  has_many :comments
end
