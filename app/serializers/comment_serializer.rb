class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :like_count, :dislike_count, :created_at, :updated_at
  has_one :user, serializer: UserSimpleSerializer
  has_many :comments
end
