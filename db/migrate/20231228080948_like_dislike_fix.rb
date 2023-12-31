class LikeDislikeFix < ActiveRecord::Migration[7.1]
  def change
    drop_table :comments_like_dislike
    drop_table :posts_like_dislike

    create_table "posts_like", force: :cascade do |t|
      t.references :users, index: true, null: false, foreign_key: true
      t.references :posts, index: true, null: false, foreign_key: true
    end

    create_table "posts_dislike", force: :cascade do |t|
      t.references :users, index: true, null: false, foreign_key: true
      t.references :posts, index: true, null: false, foreign_key: true
    end

    create_table "comments_like", force: :cascade do |t|
      t.references :users, index: true, null: false, foreign_key: true
      t.references :comments, index: true, null: false, foreign_key: true
    end

    create_table "comments_dislike", force: :cascade do |t|
      t.references :users, index: true, null: false, foreign_key: true
      t.references :comments, index: true, null: false, foreign_key: true
    end

    remove_column :posts_like, :id
    remove_column :posts_dislike, :id
    remove_column :comments_like, :id
    remove_column :comments_dislike, :id

    rename_column :posts_like, :users_id, :user_id
    rename_column :posts_like, :posts_id, :post_id
    rename_column :posts_dislike, :users_id, :user_id
    rename_column :posts_dislike, :posts_id, :post_id

    rename_column :comments_like, :users_id, :user_id
    rename_column :comments_like, :comments_id, :comment_id
    rename_column :comments_dislike, :users_id, :user_id
    rename_column :comments_dislike, :comments_id, :comment_id

    execute "ALTER TABLE posts_like ADD PRIMARY KEY (user_id, post_id)"
    execute "ALTER TABLE posts_dislike ADD PRIMARY KEY (user_id, post_id)"
    execute "ALTER TABLE comments_like ADD PRIMARY KEY (user_id, comment_id)"
    execute "ALTER TABLE comments_dislike ADD PRIMARY KEY (user_id, comment_id)"
  end
end
