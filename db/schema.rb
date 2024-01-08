# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_07_105038) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.integer "comments_likes_count", default: 0, null: false
    t.integer "comments_dislikes_count", default: 0, null: false
    t.bigint "user_id"
    t.bigint "post_id", null: false
    t.bigint "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "comments_dislikes", primary_key: ["user_id", "comment_id"], force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comment_id", null: false
    t.index ["comment_id"], name: "index_comments_dislikes_on_comment_id"
    t.index ["user_id"], name: "index_comments_dislikes_on_user_id"
  end

  create_table "comments_likes", primary_key: ["user_id", "comment_id"], force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comment_id", null: false
    t.index ["comment_id"], name: "index_comments_likes_on_comment_id"
    t.index ["user_id"], name: "index_comments_likes_on_user_id"
  end

  create_table "post_tags", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_tags_on_post_id"
    t.index ["tag_id"], name: "index_post_tags_on_tag_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "title", null: false
    t.text "body"
    t.integer "posts_likes_count", default: 0, null: false
    t.integer "posts_dislikes_count", default: 0, null: false
    t.text "image"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comments_count", default: 0
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_dislikes", primary_key: ["user_id", "post_id"], force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.index ["post_id"], name: "index_posts_dislikes_on_post_id"
    t.index ["user_id"], name: "index_posts_dislikes_on_user_id"
  end

  create_table "posts_likes", primary_key: ["user_id", "post_id"], force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.index ["post_id"], name: "index_posts_likes_on_post_id"
    t.index ["user_id"], name: "index_posts_likes_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_text", null: false
    t.string "colour", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: true
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "username", null: false
    t.string "image"
    t.string "bio"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vieweds", primary_key: ["user_id", "post_id"], force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.index ["post_id"], name: "index_vieweds_on_post_id"
    t.index ["user_id"], name: "index_vieweds_on_user_id"
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users", on_delete: :nullify
  add_foreign_key "comments_dislikes", "comments"
  add_foreign_key "comments_dislikes", "users"
  add_foreign_key "comments_likes", "comments"
  add_foreign_key "comments_likes", "users"
  add_foreign_key "post_tags", "posts"
  add_foreign_key "post_tags", "tags"
  add_foreign_key "posts", "users", on_delete: :nullify
  add_foreign_key "posts_dislikes", "posts"
  add_foreign_key "posts_dislikes", "users"
  add_foreign_key "posts_likes", "posts"
  add_foreign_key "posts_likes", "users"
  add_foreign_key "vieweds", "posts"
  add_foreign_key "vieweds", "users"
end
