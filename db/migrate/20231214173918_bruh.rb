class Bruh < ActiveRecord::Migration[7.1]
  def change
    create_table "posts", force: :cascade do |t|
      t.text "title",                 null: false
      t.text "body"
      t.integer "like_count",         null: false, default: 0
      t.integer "dislike_count",      null: false, default: 0
      t.text "image"
      t.bigint "user_id",             null: false
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.index ["user_id"], name: "index_posts_on_user_id"
    end

    create_table "tags", force: :cascade do |t|
      t.string "tag_text",              null: false
      t.string "colour",                null: false
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
    end

    create_table "post_tags", force: :cascade do |t|
      t.bigint "tag_id",                null: false
      t.bigint "post_id",               null: false
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.index ["post_id"], name: "index_post_tags_on_post_id"
      t.index ["tag_id"], name: "index_post_tags_on_tag_id"
    end

    create_table "comments", force: :cascade do |t|
      t.text "body",                    null: false
      t.integer "like_count",           null: false, default: 0
      t.integer "dislike_count",        null: false, default: 0
      t.bigint "user_id",               null: false
      t.bigint "post_id"
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.bigint "comment_id"
      t.index ["comment_id"], name: "index_comments_on_comment_id"
      t.index ["post_id"], name: "index_comments_on_post_id"
      t.index ["user_id"], name: "index_comments_on_user_id"
    end

    add_foreign_key "comments", "posts"
    add_foreign_key "comments", "users"
    add_foreign_key "post_tags", "posts"
    add_foreign_key "post_tags", "tags"
    add_foreign_key "posts", "users"
  end
end
