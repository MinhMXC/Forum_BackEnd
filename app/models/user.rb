# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  devise authentication_keys: [:username, :email]

  has_many :posts
  has_many :comments

  has_many :vieweds, dependent: :delete_all
  has_many :comments_likes, dependent: :delete_all
  has_many :comments_dislikes, dependent: :delete_all
  has_many :posts_likes, dependent: :delete_all
  has_many :posts_dislikes, dependent: :delete_all

  # comparison also check for blank
  validates :username, comparison: { other_than: "[deleted]" }
  validates :username, uniqueness: { case_sensitive: true }
end
