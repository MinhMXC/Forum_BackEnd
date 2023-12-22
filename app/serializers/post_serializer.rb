class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :like_count, :dislike_count, :image, :visited, :comments_count, :created_at, :updated_at
  has_one :user, serializer: UserSimpleSerializer
  has_many :comments
  has_many :tags

  def comments
    object.comments.where( comment_id: nil )
  end
end
