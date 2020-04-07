# frozen_string_literal: true

class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :author, class_name: 'User', foreign_key: :author_id

  field :title, type: String
  field :body, type: String

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
end
