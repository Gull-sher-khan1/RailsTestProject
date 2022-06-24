# frozen_string_literal: true

class Following < ApplicationRecord
  belongs_to :user, inverse_of: :followings
  belongs_to :follower, class_name: :User, inverse_of: :requests

  validates :user_id, presence: true, uniqueness: { scope: :follower_id }

  scope :pending_requests, ->(id) {where(user_id: id, request_accepted: false)}
end
