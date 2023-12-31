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

  # comparison also check for blank
  validates :username, comparison: { other_than: "[deleted]" }
  validates :username, uniqueness: { case_sensitive: true }
end
