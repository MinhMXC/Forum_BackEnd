class ChangeVisitedImplementation < ActiveRecord::Migration[7.1]
  def change
    #  This implementation is logically flawed
    remove_column :posts, :visited

    create_table "viewed", primary_key: ["user_id", "post_id"], force: :cascade do |t|
      t.bigint "user_id", null: false
      t.bigint "post_id", null: false
      t.index ["post_id"], name: "index_viewed_on_post_id"
      t.index ["user_id"], name: "index_viewed_on_user_id"
    end
  end
end
