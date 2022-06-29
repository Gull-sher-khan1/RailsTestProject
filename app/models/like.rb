# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user, inverse_of: :likes

  validates :user_id, presence: true, uniqueness: { scope: %i[likeable_type likeable_id] }

  scope :like_users, -> { where(likeable_type: :Post) }
  scope :post_like, ->(id) { where(likeable_id: id) }
  scope :posts_like, -> { where(likeable_type: :Post) }
  scope :get_user_likes, lambda { |post_id, current_user_id|
                           where(likeable_id: post_id, user_id: current_user_id).pluck(:id)
                         }
end
