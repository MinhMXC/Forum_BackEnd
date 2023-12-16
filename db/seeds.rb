PostTag.destroy_all
Comment.destroy_all
Tag.destroy_all
Post.destroy_all
ActiveRecord::Base.connection.execute("TRUNCATE TABLE comments, posts, post_tags, tags RESTART IDENTITY")

Tag.create!(
  {
    tag_text: "bruh",
    colour: "bruh"
  }
)

Post.create!(
  {
    title: "bruh",
    body: "bruh",
    user_id: 1,
    tag_ids: [1]
  }
)

comment1 = Comment.create!(
  {
    body: "bruh",
    user_id: 1,
    post_id: 1
  }
)

comment2 = Comment.create!(
  {
    body: "bruh1",
    user_id: 1,
    comment: comment1
  }
)

Comment.create!([
  {
    body: "bruh",
    user_id: 1,
    post_id: 1
  },
  {
    body: "bruh1",
    user_id: 1,
    comment: comment1
  },
  {
    body: "bruh2",
    user_id: 1,
    comment: comment2
  }
])