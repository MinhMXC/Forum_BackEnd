class SetOnDeleteNull < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :comments, column: :user_id
    add_foreign_key :comments, :users, column: :user_id, on_delete: :nullify

    remove_foreign_key :posts, column: :user_id
    add_foreign_key :posts, :users, column: :user_id, on_delete: :nullify
  end
end
