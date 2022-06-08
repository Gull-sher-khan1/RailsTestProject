class Following < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: :follower_id }
  belongs_to :user
  belongs_to :follower, class_name: "User"
end
