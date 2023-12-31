class ChangeCommentLikeDislikeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :like_count, :comments_likes_count
    rename_column :comments, :dislike_count, :comments_dislikes_count
  end
end
