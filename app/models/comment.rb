class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  has_many :comments

  validates :body, :user_id, presence: true, comparison: { other_than: "[deleted]" }
  validates_length_of :body, maximum: 20000
  validates_presence_of :post_id, :unless => :comment_id?
  validates_absence_of :post_id, :if => :comment_id.presence
end
