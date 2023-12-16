class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, :through => :post_tags
  has_many :comments

  validates :title, :body, :user_id, presence: true, comparison: { other_than: "[deleted]" }
  validates_length_of :title, maximum: 300
  validates_length_of :body,  maximum: 40000
end