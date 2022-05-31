class Following < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: "user"
end
