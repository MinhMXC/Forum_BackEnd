class ChangeDateTimeToEpoch < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :updated_at
    remove_column :comments, :created_at
    add_column :comments, :created_at, :bigint
    add_column :comments, :updated_at, :bigint

    remove_column :posts, :updated_at
    remove_column :posts, :created_at
    add_column :posts, :created_at, :bigint
    add_column :posts, :updated_at, :bigint

    remove_column :users, :updated_at
    remove_column :users, :created_at
    add_column :users, :created_at, :bigint
    add_column :users, :updated_at, :bigint

    remove_column :tags, :updated_at
    remove_column :tags, :created_at
    add_column :tags, :created_at, :bigint
    add_column :tags, :updated_at, :bigint

    remove_column :post_tags, :updated_at
    remove_column :post_tags, :created_at
    add_column :post_tags, :created_at, :bigint
    add_column :post_tags, :updated_at, :bigint
  end
end
