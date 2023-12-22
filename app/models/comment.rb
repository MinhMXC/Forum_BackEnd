class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  belongs_to :comment, optional: true
  has_many :comments

  validates :body, :user_id, presence: true, comparison: { other_than: "[deleted]" }
  validates_length_of :body, maximum: 20000
end
