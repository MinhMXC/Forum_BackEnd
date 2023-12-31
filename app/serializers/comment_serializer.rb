class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :comments_likes_count, :comments_dislikes_count, :deleted, :userState, :owner, :post_id, :created_at, :updated_at
  has_one :user, serializer: UserSimpleSerializer
  has_many :comments

  # userState: -2 => not logged in, -1 => dislike, 0 => none, 1 => like
  def userState
    current_user = @instance_options[:current_user]
    comment_id = object.id

    if current_user == nil
      -2
    elsif CommentsLike.find_by(user_id: current_user[:id], comment_id: comment_id)
      1
    elsif CommentsDislike.find_by(user_id: current_user[:id], comment_id: comment_id)
      -1
    else
      0
    end
  end

  def owner
    current_user = @instance_options[:current_user]
    if current_user == nil
      return false
    end

    object.user_id === current_user[:id]
  end

  def user
    if object.deleted
      User.new({:id => -1, :username => "[deleted]", :image => "[deleted]"})
    else
      object.user
    end
  end
end
