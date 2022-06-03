class Post < ApplicationRecord
  validates :text, presence: true
  belongs_to :user,  inverse_of: :posts
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachable
  has_many :likes, as: :likeable
end
