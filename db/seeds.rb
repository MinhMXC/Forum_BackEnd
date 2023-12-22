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

def create_post(n)
  title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
  text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, sem nec pulvinar gravida, sapien dui placerat sem, id malesuada libero elit sed sem. Morbi ultricies augue sed arcu tempor egestas. Nulla porta neque eget ullamcorper ullamcorper. Phasellus congue lorem purus, ut posuere sapien ultricies aliquet. Integer aliquam fermentum iaculis. Donec maximus sem ut fringilla pellentesque. Morbi feugiat nisi nec felis pharetra, sed porta mauris bibendum. Nunc elit nunc, sodales sed placerat eu, maximus vel metus. Aenean a finibus eros. Nunc ut purus egestas orci consectetur egestas. Quisque laoreet molestie sapien et euismod. Suspendisse tincidunt viverra sapien ac rhoncus. Donec maximus fringilla mattis."

  for i in 1..n
    post = Post.create!({ title: title, body: text, user_id: 1, tag_ids: [1] })
    comment1 = Comment.create!( {  body: text,  user_id: 1,  post: post })
    comment2 = Comment.create!( {  body: text,  user_id: 1,  post: post, comment: comment1 })
    Comment.create!([ {body: text, user_id: 1, post: post}, {body: text, user_id: 1, post: post, comment: comment1}, {body: text, user_id: 1, post: post, comment: comment2}, ])
  end
end

create_post(2)