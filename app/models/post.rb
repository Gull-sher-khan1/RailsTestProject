# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user, inverse_of: :posts
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :text, presence: true

  scope :user_posts, -> { includes(:user)}
  scope :get_ids, -> {pluck(:id)}
  scope :get_posts, ->(user) {where(user_id: user.id)}
end
