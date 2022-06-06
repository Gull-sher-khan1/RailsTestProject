class Post < ApplicationRecord
  validates :text, presence: true
  belongs_to :user,  inverse_of: :posts
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
