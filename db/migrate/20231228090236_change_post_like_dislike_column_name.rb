class ChangePostLikeDislikeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :like_count, :posts_like_count
    rename_column :posts, :dislike_count, :posts_dislike_count
  end
end
