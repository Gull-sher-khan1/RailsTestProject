# frozen_string_literal: true

class Following < ApplicationRecord
  belongs_to :user, inverse_of: :followings
  belongs_to :follower, class_name: :User, inverse_of: :requests

  validates :user_id, presence: true, uniqueness: { scope: :follower_id }

  scope :pending_requests, ->(id) { where(user_id: id, request_accepted: false) }
  scope :get_request, lambda { |profile_user_id, current_user_id|
                        where(user_id: profile_user_id, follower_id: current_user_id).pluck
                      }
  scope :request_count, ->(id) { where(user_id: id, request_accepted: false).count }
end
