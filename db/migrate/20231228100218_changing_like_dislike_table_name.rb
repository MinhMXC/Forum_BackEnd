class ChangingLikeDislikeTableName < ActiveRecord::Migration[7.1]
  def change
    rename_table :posts_like, :posts_likes
    rename_table :posts_dislike, :posts_dislikes

    rename_table :comments_like, :comments_likes
    rename_table :comments_dislike, :comments_dislikes

    rename_column :posts, :posts_like_count, :posts_likes_count
    rename_column :posts, :posts_dislike_count, :posts_dislikes_count
  end
end
