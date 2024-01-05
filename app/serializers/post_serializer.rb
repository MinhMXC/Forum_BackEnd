class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :posts_likes_count, :posts_dislikes_count, :image, :visited, :comments_count, :userState, :owner, :created_at, :updated_at
  has_one :user, serializer: UserSimpleSerializer
  has_many :comments
  has_many :tags

  def comments
    object.comments.where( comment_id: nil )
  end

  # userState: -2 => not logged in, -1 => dislike, 0 => none, 1 => like
  def userState()
    current_user = @instance_options[:current_user]
    post_id = object.id

    if current_user == nil
      -2
    elsif PostsLike.find_by(user_id: current_user[:id], post_id: post_id)
      1
    elsif PostsDislike.find_by(user_id: current_user[:id], post_id: post_id)
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
    object.user_id == current_user[:id]
  end

  def user
    if object.user == nil
      User.new({:id => -1, :username => "[deleted]", :image => "[deleted]"})
    else
      object.user
    end
  end
end
