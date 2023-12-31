class AddDeletedStateToPostCommentsAndUser < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :deleted, :boolean, null: false, default: false
    add_column :posts, :deleted, :boolean, null: false, default: false
    add_column :users, :deleted, :boolean, null: false, default: false
  end
end
