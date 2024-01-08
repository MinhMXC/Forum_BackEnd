class FixVisitedTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :viewed

    create_table "viewed", force: :cascade do |t|
      t.references :users, index: true, null: false, foreign_key: true
      t.references :posts, index: true, null: false, foreign_key: true
    end

    remove_column :viewed, :id

    rename_column :viewed, :users_id, :user_id
    rename_column :viewed, :posts_id, :post_id

    execute "ALTER TABLE viewed ADD PRIMARY KEY (user_id, post_id)"
  end
end
