class RollBackToDateTime < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :updated_at
    remove_column :comments, :created_at
    add_column :comments, :created_at, :datetime, null: false
    add_column :comments, :updated_at, :datetime, null: false

    remove_column :posts, :updated_at
    remove_column :posts, :created_at
    add_column :posts, :created_at, :datetime, null: false
    add_column :posts, :updated_at, :datetime, null: false

    remove_column :tags, :updated_at
    remove_column :tags, :created_at
    add_column :tags, :created_at, :datetime, null: false
    add_column :tags, :updated_at, :datetime, null: false

    remove_column :post_tags, :updated_at
    remove_column :post_tags, :created_at
    add_column :post_tags, :created_at, :datetime, null: false
    add_column :post_tags, :updated_at, :datetime, null: false

    remove_column :users, :updated_at
    remove_column :users, :created_at
    add_column :users, :created_at, :datetime, null: false
    add_column :users, :updated_at, :datetime, null: false
  end
end
