class ChangeDeleteImplementation < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :deleted
    remove_column :posts, :deleted
    remove_column :users, :deleted

    change_column_null :comments, :user_id, true
    change_column_null :posts, :user_id, true
  end
end
