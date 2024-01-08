# frozen_string_literal: true

class Viewed < ActiveRecord::Base
  has_many :posts
  has_many :users
end
