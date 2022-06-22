# frozen_string_literal: true

class Following < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: :follower_id }
  belongs_to :user, inverse_of: :followings
  belongs_to :follower, class_name: 'User', inverse_of: :requests

  scope :pending_requests, ->(id) {includes(:user).where(user_id: id, request_accepted: false)}
end
