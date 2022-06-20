class Like < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: [:likeable_type, :likeable_id] }
  belongs_to :likeable, polymorphic: true
  belongs_to :user, inverse_of: :likes
end
