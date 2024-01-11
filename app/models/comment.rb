class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  belongs_to :comment, optional: true
  has_many :comments
  has_many :comments_likes
  has_many :comments_dislikes

  validates :user_id, presence: true
  validates :body, comparison: { other_than: "[deleted]" }
  validates :body, comparison: { other_than: "<p></p>" }

  validates_length_of :body, maximum: 20000
end
