class Comment < ApplicationRecord
  validates :text, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable
end
