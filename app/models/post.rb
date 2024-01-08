class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, :through => :post_tags
  has_many :comments
  has_many :posts_likes
  has_many :posts_dislikes

  validates :user_id, presence: true
  validates :title, comparison: { other_than: "[deleted]" }
  validates :body, comparison: { other_than: "[deleted]" }

  validates_length_of :title, maximum: 300
  validates_length_of :body, maximum: 40000
end